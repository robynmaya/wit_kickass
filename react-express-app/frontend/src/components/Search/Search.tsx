const Search = ({
  value,
  handleSearch,
}: {
  value: string;
  handleSearch: (searchTerm: string) => void;
}) => {
  return (
    <>
      <input
        className='todos-search-input'
        type='text'
        value={value}
        onChange={(e) => handleSearch(e.target.value)}
        placeholder='Search todos...'
      />
    </>
  );
};

export default Search;
