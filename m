Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75561FF3;
	Wed,  5 Jun 2024 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717556913; cv=none; b=shU7zWqZu4Lu9yeU25J/zashLO9vfRXBgCYygcRL1zDDcNKk75PezIW/+SM2ziKHvTmXfLbmeQYkvXPbvjBrTnHUpNqpmo/ZMhZHtzjnB6bsJg9/wVBfWKqp+KT5AqRCCo64Lfc7ZmpOvGwhxxelK2e5CPmEe0y1v4b7XxA+fao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717556913; c=relaxed/simple;
	bh=v9/EYBr9mPsr5ufsnMWdpGRxyzDcht+E82KfMBBjImU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nczTN+rLiNfxGu3E+KHzOhBqMcsexwNYJkPBhbyTNUT5XaeBDo8DO9dZuJnCEf7xuKOjjEVBPU5CcZrpCUNQClVNPozfs+JEgREq6MlDD5aliQ1qr6HJJF6mR/wukqBUa7mYMOytbs1Ydy0ftBxYOdgjklRXzuZwHnSG02pLj68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBYBhuJl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBYBhuJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717556912; x=1749092912;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v9/EYBr9mPsr5ufsnMWdpGRxyzDcht+E82KfMBBjImU=;
  b=bBYBhuJlOZ7ZrvgIVmIgOuCzgyjs8iRlEmhwMq4yi34E9KlgztwXRRgt
   TtGfpY4lPSz1BWpYH8p9MPSpcK9Wvydq/dDVJefk3uXN+O/l6xryth+Ep
   UGewLFtZKdgT4esfHJCtSNYIUUJ78rzZnRT79a9WSM5vUacOza2ssYD1p
   xL7ZVtJadhdFbcP1rIcetBpCQFXgD3Y/jg+HvZ8EQCqChRVzD+8YjxNCl
   Q5qst3H9+V6YVs0j3NJQLcVG4FDcYNCrc8+kzMs42TG4OX8iGC/2QNe5I
   tZg1+pFbZYI2EOcVSIw8DCsxiCQk8jO+W7i+F3mbHF/ppnunc/HB9JTk+
   w==;
X-CSE-ConnectionGUID: 7f0qoeNUQiWNPdoIfrtk2w==
X-CSE-MsgGUID: 6BgoYxjoR32+EtlJLRc8MQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13980810"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13980810"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 20:08:31 -0700
X-CSE-ConnectionGUID: LzFqRSULQSCzNjKDeyg6Cw==
X-CSE-MsgGUID: uxo3awcKQhODJQ52+l7lpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="37559640"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2024 20:08:27 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEh0j-0000qh-1R;
	Wed, 05 Jun 2024 03:08:25 +0000
Date: Wed, 5 Jun 2024 11:07:58 +0800
From: kernel test robot <lkp@intel.com>
To: Zqiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, urezki@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhixu.liu@gmail.com
Subject: Re: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtpcp
 variable in rcu_tasks_need_gpcb()
Message-ID: <202406051045.FpU0Oi69-lkp@intel.com>
References: <20240604085401.14733-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604085401.14733-1-qiang.zhang1211@gmail.com>

Hi Zqiang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on paulmck-rcu/dev]
[also build test WARNING on linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tasks-Fix-access-non-existent-percpu-rtpcp-variable-in-rcu_tasks_need_gpcb/20240604-165702
base:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
patch link:    https://lore.kernel.org/r/20240604085401.14733-1-qiang.zhang1211%40gmail.com
patch subject: [PATCH v2] rcu-tasks: Fix access non-existent percpu rtpcp variable in rcu_tasks_need_gpcb()
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20240605/202406051045.FpU0Oi69-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051045.FpU0Oi69-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051045.FpU0Oi69-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/rcu/update.o: warning: objtool: unexpected relocation symbol type in .rela.discard.unreachable

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
