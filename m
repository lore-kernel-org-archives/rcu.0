Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F930C629;
	Wed, 10 Jun 2026 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121046; cv=none; b=HOls0MHPYiCjYjIYy1637Z3iMEvWJTRiyQCHAip8CHRdGqHodQvhldPx/4yBp2tEXUUiL4gXZC7nekigE/ETgELLXNvOgMBCf7fUpu5x4uuc/BaIIMnP9bU/DcUcQZdDlaCybL/mTeCIgEG2K8dh51ZEvbn4UZas+SZGxB5iU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121046; c=relaxed/simple;
	bh=NNksoh7Ns2g1gqLHnb6MZ59thijmaV2sFavKgQ6aShA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko4Q9YS0OVmfQUV0OBe8JNOtZ/1UiDrhPrGr9Ppxux8U4LwZmRfYKpbwL6kgyYFaA/9zvV6mC51fL9kuOUqLdKwksVBp6JNN3VFOtfz8iCFVpC2d9wtR1sNc89Ly5Wi4v17qSEZf4E3C2tM0J5JLf+ym3A1jyq1HMI1PgIEMZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUCOdF8Q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUCOdF8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781121046; x=1812657046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NNksoh7Ns2g1gqLHnb6MZ59thijmaV2sFavKgQ6aShA=;
  b=LUCOdF8QCa3t587tvEB6/Rf0gBjjoVdW5HRXrVtzLlXQhTLvHSpsKFiX
   +51jwTZGscF7t1epclLlfteXB0ULoq9t7f/m1/xfQ1ySp6FJZ3HOqFxkR
   Z2sIN4KWYEUO+d7RlUwUo8q+pxw/nH0P7QkDvHt5UUAcXKe0A52hA/OQr
   7ahB9Wgwki+t0bmlJhiNyft2Zk4oxVHrLUKSChKjmQ9Ez1Mcacm1y1IGC
   t44KE7fIUTNjAb7Tmmp9NX5ZE7WS+9l9EuJOgJ0ByNXzlZ2aMdsOezMfo
   5x1IzqWGe4zNzG1CCNqJvnhuw5ZDZwToSK0eYJN8u410wNQUPa8+uE5RK
   A==;
X-CSE-ConnectionGUID: MP9QI3VQQbS44nJ0N5E/xg==
X-CSE-MsgGUID: 5/fvOypgRe6UCOcZcCJtqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81902011"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81902011"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 12:50:45 -0700
X-CSE-ConnectionGUID: MNol4bm2Su26hykbOpkGTA==
X-CSE-MsgGUID: QjEYvZrpRMO1aH1q6gDrCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243312217"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jun 2026 12:50:40 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXOwf-000000003oP-4AsC;
	Wed, 10 Jun 2026 19:50:37 +0000
Date: Wed, 10 Jun 2026 21:50:06 +0200
From: kernel test robot <lkp@intel.com>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ojeda@kernel.org,
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org,
	fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Subject: Re: [PATCH v9 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
Message-ID: <202606102148.n3zUlB8z-lkp@intel.com>
References: <20260529134004.396743-5-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529134004.396743-5-work@onurozkan.dev>

Hi Onur,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rcu/rcu/dev]
[also build test WARNING on rust/rust-next linus/master v7.1-rc7 next-20260610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Onur-zkan/rust-helpers-add-SRCU-helpers/20260529-214529
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git rcu/dev
patch link:    https://lore.kernel.org/r/20260529134004.396743-5-work%40onurozkan.dev
patch subject: [PATCH v9 4/4] MAINTAINERS: add Rust SRCU files to SRCU entry
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260610/202606102148.n3zUlB8z-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project f43d6834093b19baf79beda8c0337ab020ac5f17)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260610/202606102148.n3zUlB8z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606102148.n3zUlB8z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/rcu/srcutree.c:305 expecting prototype for init_srcu_struct(). Prototype was for init_srcu_struct_generic() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
