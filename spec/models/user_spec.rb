require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  context 'associations' do

    [:languages, :roles, :licenses].each do |associat|
      it "has and belongs to many #{ associat }" do
        expect(User.reflect_on_association(associat).macro).to eq(:has_and_belongs_to_many)
      end
    end
  end

  context 'validations' do

    [:gender, :firstname, :lastname, :username, :tel, :email].each do |attr|
      it "is invalid without #{attr}" do
        user = FactoryGirl.build(:user, attr => nil)
        expect(user).to be_invalid
        expect(user.errors.keys).to eql([attr])
      end
    end
  end

  context 'bank data' do

    it 'is valid without bank, blz and konto when user does not have referent role' do
      user = FactoryGirl.create(:user, bank: nil, blz: nil, konto: nil)
      expect(user).to be_valid
    end

    [:bank, :blz, :konto].each do |attr|
      it "is invalid without #{attr} if user has 'referent' role" do
        user = FactoryGirl.create(:referent)
        user.send("#{attr}=", nil)
        expect(user).to be_invalid
        expect(user.errors.keys).to eql([attr])
      end
    end
  end

  context 'assign_languages' do

    before do
      @user = FactoryGirl.create(:user)
    end

    it 'assignes given languages to himself' do
      english = FactoryGirl.create(:english)
      german = FactoryGirl.create(:german)
      FactoryGirl.create(:russian)

      expect(@user.languages.count).to eql(0)
      @user.assign_languages([english.id, german.id])

      expect(@user.languages.count).to eql(2)
      expect(@user.languages.map(&:language)).to match_array(['Englisch', 'Deutsch'])
      expect(@user.languages.map(&:language)).not_to include('Russisch')
    end

    it 'reassigns languages from himself if no languages given' do
      english = FactoryGirl.create(:language)
      @user.languages << english
      expect(@user.languages.count).to eql(1)

      @user.assign_languages([])

      expect(@user.languages.count).to eql(0)
    end

    it 'reassigns languages if nil given' do
      english = FactoryGirl.create(:language)
      @user.languages << english
      expect(@user.languages.count).to eql(1)

      @user.assign_languages(nil)

      expect(@user.languages.count).to eql(0)
    end
  end

  context 'assign_roles' do

    before do
      @user = FactoryGirl.create(:user)
      @admin_role = FactoryGirl.create(:admin_role)
    end

    it 'assignes given roles to himself' do
      expect(@user.roles).to match_array([])

      @user.assign_roles([@admin_role.id])
      expect(@user.roles).to match_array([@admin_role])
    end

    it 'reassignes languages from himself if no roles given' do
      @user.roles << @admin_role
      expect(@user.roles).to match_array([@admin_role])

      @user.assign_roles([])
      expect(@user.roles).to match_array([])
    end

    it 'reasignes languages if nil given' do
      @user.roles << @admin_role
      expect(@user.roles).to match_array([@admin_role])

      @user.assign_roles(nil)
      expect(@user.roles).to match_array([])
    end
  end

  context 'assign_licenses' do

    before do
      @user = FactoryGirl.create(:user)
    end

    it 'assignes given licenses to himself' do
      a_license = FactoryGirl.create(:license)
      b_license = FactoryGirl.create(:license)
      FactoryGirl.create(:license)

      expect(@user.licenses.count).to eql(0)
      @user.assign_licenses([a_license.id, b_license.id])

      expect(@user.licenses.count).to eql(2)
      expect(@user.licenses).to match_array [a_license, b_license]
    end

    it 'reassigns licenses from himself if empty array given' do
      a_license = FactoryGirl.create(:license)
      @user.licenses << a_license
      expect(@user.licenses.count).to eql(1)

      @user.assign_licenses([])

      expect(@user.licenses.count).to eql(0)
    end

    it 'reassigns licenses if nil given' do
      a_license = FactoryGirl.create(:license)
      @user.licenses << a_license
      expect(@user.licenses.count).to eql(1)

      @user.assign_licenses(nil)

      expect(@user.licenses.count).to eql(0)
    end
  end

  context 'has role' do

    before do
      @user = FactoryGirl.create(:user)
    end

    context 'is_referent?' do

      it 'returns true if it has a role referent' do
        referent_role = FactoryGirl.create(:referent_role)
        @user.roles << referent_role
        expect(@user.is_referent?).to eql(true)
      end

      it 'returns false if it does not have a role referent' do
        expect(@user.is_referent?).to eql(false)
      end
    end

    context 'is_admin?' do

      it 'returns true if it has a role admin' do
        admin_role = FactoryGirl.create(:admin_role)
        @user.roles << admin_role
        expect(@user.is_admin?).to eql(true)
      end

      it 'returns false if it does not have a role admin' do
        expect(@user.is_admin?).to eql(false)
      end
    end
  end

  context 'ordered_by_name' do
    before do
      @luser_luser = FactoryGirl.create(:user, lastname: 'Luser', firstname: 'Luser')
      @auser = FactoryGirl.create(:user, lastname: 'Auser')
    end

    context ' with parameter *' do
      it 'return users ordered by lastname' do
        expect(User.ordered_by_name('*')).to eq([@auser, @luser_luser])
      end

      it 'return users ordered by firstname if same lastname' do
        luser_buser = FactoryGirl.create(:user, lastname: 'Luser', firstname: 'Buser')
        expect(User.ordered_by_name('*')).to eq([@auser, luser_buser, @luser_luser])
      end
    end

    context 'with letter parameter' do

      it 'return users with lastname starting with letter and ordered by lastname' do
        laser = FactoryGirl.create(:user, lastname: 'Laser')
        expect(User.ordered_by_name('L')).to eq([laser, @luser_luser])
      end

      it 'return users ordered by firstname if same lastname and starts with letter' do
        luser_buser = FactoryGirl.create(:user, lastname: 'Luser', firstname: 'Buser')
        expect(User.ordered_by_name('L')).to eq([luser_buser, @luser_luser])
      end

      it 'return empty array if no user with lastname starting with letter' do
        FactoryGirl.create(:user, lastname: 'Luser', firstname: 'Buser')
        expect(User.ordered_by_name('X')).to eq([])
      end
    end
  end

  context 'present_abc' do

    it 'returns array of unique ordered letters, wich are first users lastname letters and "*"' do
      FactoryGirl.create(:user, lastname: 'Cuser')
      FactoryGirl.create(:user, lastname: 'Cuser')
      FactoryGirl.create(:user, lastname: 'Auser')
      FactoryGirl.create(:user, lastname: 'Buser')

      expect(User.present_abc).to eq(['*', 'A', 'B', 'C'])
    end

    it 'returns array of upcased letters and "*"' do
      FactoryGirl.create(:user, lastname: 'Cuser')
      FactoryGirl.create(:user, lastname: 'cuser')
      FactoryGirl.create(:user, lastname: 'Auser')
      FactoryGirl.create(:user, lastname: 'buser')

      expect(User.present_abc).to eq(['*', 'A', 'B', 'C'])
    end
  end

  context 'full_name' do

    it 'returns firstname and lastname for user' do
      user = FactoryGirl.create(:user)
      expect(user.full_name).to eql "#{ user.firstname } #{ user.lastname }"
    end
  end

  context 'can_be_removed?' do

    [:admin, :accounter, :reader, :dbuser].each do |role|
      it "returns true for #{ role } role" do
        user = FactoryGirl.create(role)
        expect(user.can_be_removed?).to eql true
      end
    end

    it 'returns false if user is referent with events assigned' do
      # TODO: implement later
      referent_user = FactoryGirl.create(:referent)
      expect(referent_user.can_be_removed?).to eql false
    end

    it 'returns true if user is referent but have no events assigned' do
      # TODO: implement later
    end
  end

  context 'referents' do

    it 'returns all users with role referent if some given' do
      referent1 = FactoryGirl.create(:referent)
      referent2 = FactoryGirl.create(:referent)
      expect(User.referents).to match_array [referent1, referent2]
    end

    it 'returns empty array if no referents given' do
      FactoryGirl.create(:referent_role)
      FactoryGirl.create(:reader)
      FactoryGirl.create(:dbuser)
      expect(User.referents).to match_array []
    end
  end

  context 'check_referent' do

    it 'returns false if referent role given and bank data is missing for new user record' do
      dbuser = FactoryGirl.build(:dbuser)
      referent_role = FactoryGirl.create(:referent_role)
      expect(dbuser.check_referent([referent_role.id])).to eql false
      expect(dbuser.errors.keys).to match_array([:bank, :blz, :konto])
    end

    it 'returns true if role is not referent' do
      dbuser = FactoryGirl.build(:dbuser)
      accounter_role = FactoryGirl.create(:accounter_role)
      expect(dbuser.check_referent([accounter_role.id])).to eql true
      expect(dbuser.errors.keys).to match_array([])
    end

    it 'returns true if refeernt role bur ban data present' do
      referent = FactoryGirl.build(:referent)
      referent_role = Role.find_by(title: 'referent')
      expect(referent.check_referent([referent_role.id])).to eql true
    end
  end

  context 'save_with_params' do
    before do
      @user = FactoryGirl.build(:user)
    end

    it 'returns false if check_referents returns false' do
      @user.bank = nil
      referent = FactoryGirl.create(:referent_role)
      expect(@user.save_with_params([referent.id])).to eql false
      expect(@user).not_to be_persisted
    end

    it 'returns false if user invalid' do
      @user.firstname = nil
      expect(@user.save_with_params).to eql false
      expect(@user).not_to be_persisted
    end

    context 'user valid' do

      it 'saves user' do
        expect(@user.save_with_params).to eql true
        expect(@user).to be_persisted
      end

      it 'assignes languages to user' do
        language = FactoryGirl.create(:language)
        @user.save_with_params(nil, [language.id])
        expect(@user.languages).to match_array([language])
      end

      it 'assignes roles to user' do
        dbuser = FactoryGirl.create(:dbuser_role)
        @user.save_with_params([dbuser.id])
        expect(@user.roles).to match_array([dbuser])
      end

      it 'assignes licenses to user' do
        license = FactoryGirl.create(:license)
        @user.save_with_params(nil, nil, [license.id])
        expect(@user.licenses).to match_array([license])
      end
    end
  end

  context 'save_referent_with_params' do
    before do
      @referent = FactoryGirl.build(:referent)
    end

    it 'return false if no referent role is given' do
      Role.find_by(title: 'referent').destroy
      expect(@referent.save_referent_with_params).to eql false
    end

    it 'returns true if save_with_params returns true' do
      allow(@referent).to receive(:save_with_params).and_return(false)
      expect(@referent.save_referent_with_params).to eql false
    end

    it 'returns false if save_with_params returns false' do
      allow(@referent).to receive(:save_with_params).and_return(true)
      expect(@referent.save_referent_with_params).to eql true
    end
  end

  context 'identic?' do
    before do
      @user = FactoryGirl.create(:user)
    end

    it 'returns true if current_user is same as instance' do
      expect(@user.identic?(@user)).to eql true
    end

    it 'returns false if current_user is not same as instance' do
      expect(@user.identic?(FactoryGirl.create(:user))).to eql false
    end
  end

  context 'change_activ' do

    before do
      @activ_referent = FactoryGirl.create(:referent, activ: 'activ')
    end

    it 'sets temporary as activ state' do
      @activ_referent.change_activ('temporary')
      expect(@activ_referent.temporary?).to eql true
    end

    it 'sets inactiv as activ state' do
      @activ_referent.change_activ('inactiv')
      expect(@activ_referent.inactiv?).to eql true
    end

    it 'sets activ as activ state' do
      inactiv_referent = FactoryGirl.create(:referent, activ: 'inactiv')
      inactiv_referent.change_activ('activ')
      expect(inactiv_referent.activ?).to eql true
    end

    it 'ads error if activ state does not exist' do
      @activ_referent.firstname = nil
      @activ_referent.change_activ('inactiv')
      expect(@activ_referent.errors[:firstname]).to eql ['darf nicht leer sein']
    end
  end

  context 'all_except_inactiv' do
    it 'returns only activ and temporary inactiv users' do
      activ_referent = FactoryGirl.create(:referent, activ: 'activ')
      FactoryGirl.create(:referent, activ: 'inactiv')
      temporary_referent = FactoryGirl.create(:referent, activ: 'temporary')
      expect(User.all_except_inactiv).to match_array [activ_referent, temporary_referent]
    end
  end

  describe '#update_with_params' do
    before do
      @user = FactoryGirl.create(:user)
    end

    it 'updates user' do
      user_params = { lastname: 'Married' }
      @user.update_with_params(user_params)
      expect(@user.lastname).to eql 'Married'
    end

    it 'assignes languages to user' do
      language = FactoryGirl.create(:language)
      @user.update_with_params({}, nil, [language.id])
      expect(@user.languages).to match_array([language])
    end

    it 'assignes roles to user' do
      dbuser = FactoryGirl.create(:dbuser_role)
      @user.update_with_params({}, [dbuser.id])
      expect(@user.roles).to match_array([dbuser])
    end

    it 'assignes licenses to user' do
      license = FactoryGirl.create(:license)
      @user.update_with_params({}, nil, nil, [license.id])
      expect(@user.licenses).to match_array([license])
    end
  end

  describe '#update_referent_with_params' do
    before do
      @referent = FactoryGirl.create(:referent)
    end

    it 'updates referent' do
      user_params = { lastname: 'Married' }
      @referent.update_with_params(user_params)
      expect(@referent.lastname).to eql 'Married'
    end

    it 'assignes languages to user' do
      language = FactoryGirl.create(:language)
      @referent.update_referent_with_params({}, [language.id])
      expect(@referent.languages).to match_array([language])
    end

    it 'assignes licenses to user' do
      license = FactoryGirl.create(:license)
      @referent.update_referent_with_params({}, nil, [license.id])
      expect(@referent.licenses).to match_array([license])
    end

    it 'does not reassign roles from user' do
      language = FactoryGirl.create(:language)
      license = FactoryGirl.create(:license)
      @referent.update_referent_with_params({}, [language.id], [license.id])
      expect(@referent.roles).to match_array([Role.find_by(title: 'referent')])
    end
  end

  describe 'update_myself' do
    it 'calls update_with_params if admin' do
      user_attrs = { lastname: 'Newname' }
      admin = FactoryGirl.create(:admin)
      role_id = Role.find_by(title: 'admin').id
      language = FactoryGirl.create(:language)
      expect(admin).to receive(:update_with_params).with(user_attrs, [role_id], [language.id], nil)

      admin.update_myself(user_attrs, [role_id], [language.id])
    end

    it 'calls update_referent_with_params if not admin' do
      user_attrs = { lastname: 'Newname' }
      user = FactoryGirl.create(:user)
      language = FactoryGirl.create(:language)
      expect(user).to receive(:update_referent_with_params).with(user_attrs, [language.id], nil)

      user.update_myself(user_attrs, nil, [language.id])
    end
  end

  describe 'inactiv' do
    it 'returns only inactiv user' do
      FactoryGirl.create(:user, activ: 'activ')
      inactiv1 = FactoryGirl.create(:user, activ: 'inactiv')
      FactoryGirl.create(:user, activ: 'temporary')
      inactiv2 = FactoryGirl.create(:user, activ: 'inactiv')
      expect(User.inactiv).to match_array([inactiv1, inactiv2])
    end
  end
end
