Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC83148B4;
	Mon, 16 Feb 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259963; cv=none; b=BU2OapNnbxR+07O6VwAtGsjZRhzz9/T3kiTOGhOvNoisr8LcoQse2ZrlPFmX5MTftiA4YjBfZucbymPUt4xfaJcWuv9R1pk6uhoDt8Ri1RIB2AgPv5pIMYgt33WdvgHSe1d+SwMAGXgwcinJSkjKyWYXcCIUDYqDSsOp7fvz+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259963; c=relaxed/simple;
	bh=z0Losj8G/4dRszkYX/isgeJrwD260mOkHbjcL4J7Tik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E47Hwfh+wedmJ/U2txqPWzqM9xquHOTSEL1ju+ScWuhWdtjboV6GF0CUCzI3+z1fcBmLYPapYgKJRQBEhh63lsrmBT8FLibPA8Usu3ejyahch0NiUjJbDYk98FmAjbVyrJQEjhRiEDrjfiP4/Ncl4Cy6zgrH5RmewdeSCgFJ5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oz8CVXAG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oz8CVXAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771259962; x=1802795962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0Losj8G/4dRszkYX/isgeJrwD260mOkHbjcL4J7Tik=;
  b=Oz8CVXAGuWPLHcGmEwsVyzue6EswbYZ/r3Zvwfb1UM+oHu7T/vDuaq+5
   QdNy3cg2LHFzn2y0Aoj12Z+zzWG8Zw00NisKug1abq1jfVta8KeH7hpMB
   c8sjYAnKhRLLBQePH5ArvB4AB044/gsjWAvZZ/VbDpi6SG0JUKDU8lCdJ
   TOC/EJc5opOsnCnhSDOHHb2KiXyCKeSyPdsi5sDURQKOiPDd9Irt/g+XW
   7Yw0EMcVdn5yRhcNPHjelI0IDUz7jhnnATLnLBpQuW7MNsSQ6gC7101mG
   LaGbanh3iq3ho3aHrBBunzpaMvW1tJeTU3O1+q0JTMOkqImW4BpK4KyJb
   A==;
X-CSE-ConnectionGUID: 7yRaX8c/R0i3wrLirV8maQ==
X-CSE-MsgGUID: gz6CPSRpQGuUBm8AKa4XQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83064825"
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; 
   d="scan'208";a="83064825"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 08:39:22 -0800
X-CSE-ConnectionGUID: ne2uYqFLTLi+cliUVGnJhA==
X-CSE-MsgGUID: ryXKlHzRRmOqSZwEF9k5dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,294,1763452800"; 
   d="scan'208";a="244237790"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Feb 2026 08:39:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vs1cw-0000000105c-3dgA;
	Mon, 16 Feb 2026 16:39:14 +0000
Date: Tue, 17 Feb 2026 00:38:27 +0800
From: kernel test robot <lkp@intel.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>, peterz@infradead.org,
	aboorvad@linux.ibm.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
	rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
	tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com,
	vishalc@linux.ibm.com
Subject: Re: [PATCH v2 2/2] cpuhp: Expedite RCU grace periods during SMT
 operations
Message-ID: <202602170049.WQD7Wcuj-lkp@intel.com>
References: <20260216121927.489062-6-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260216121927.489062-6-vishalc@linux.ibm.com>

Hi Vishal,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260213]
[also build test ERROR on linus/master]
[cannot apply to tip/smp/core rcu/rcu/dev v6.19 v6.19-rc8 v6.19-rc7 v6.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vishal-Chourasia/cpuhp-Optimize-SMT-switch-operation-by-batching-lock-acquisition/20260216-202247
base:   next-20260213
patch link:    https://lore.kernel.org/r/20260216121927.489062-6-vishalc%40linux.ibm.com
patch subject: [PATCH v2 2/2] cpuhp: Expedite RCU grace periods during SMT operations
config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20260217/202602170049.WQD7Wcuj-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project e86750b29fa0ff207cd43213d66dabe565417638)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260217/202602170049.WQD7Wcuj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602170049.WQD7Wcuj-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: duplicate symbol: rcu_expedite_gp
   >>> defined at update.c
   >>>            kernel/rcu/update.o:(rcu_expedite_gp) in archive vmlinux.a
   >>> defined at srcutiny.c
   >>>            kernel/rcu/srcutiny.o:(.text+0x1) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: rcu_unexpedite_gp
   >>> defined at update.c
   >>>            kernel/rcu/update.o:(rcu_unexpedite_gp) in archive vmlinux.a
   >>> defined at srcutiny.c
   >>>            kernel/rcu/srcutiny.o:(.text+0x41) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: rcu_expedite_gp
   >>> defined at update.c
   >>>            kernel/rcu/update.o:(rcu_expedite_gp) in archive vmlinux.a
   >>> defined at tiny.c
   >>>            kernel/rcu/tiny.o:(.text+0x1) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: rcu_unexpedite_gp
   >>> defined at update.c
   >>>            kernel/rcu/update.o:(rcu_unexpedite_gp) in archive vmlinux.a
   >>> defined at tiny.c
   >>>            kernel/rcu/tiny.o:(.text+0x41) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: rcu_expedite_gp
   >>> defined at update.c
   >>>            kernel/rcu/update.o:(rcu_expedite_gp) in archive vmlinux.a
   >>> defined at slab_common.c
   >>>            mm/slab_common.o:(.text+0x1) in archive vmlinux.a
--
>> ld.lld: error: duplicate symbol: rcu_unexpedite_gp
   >>> defined at update.c
   >>>            kernel/rcu/update.o:(rcu_unexpedite_gp) in archive vmlinux.a
   >>> defined at slab_common.c
   >>>            mm/slab_common.o:(.text+0x41) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
