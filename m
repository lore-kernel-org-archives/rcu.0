Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81A83A07;
	Fri, 16 Aug 2024 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788660; cv=none; b=h59Nm2ryWSjrhTKdJkHQjONRE3bFwIoC61Hx/xMuum8PF+JXTr7qlebq8Z8OQIuFOVOcBr9QXThhyTtPmLmtwkibDdJZjmXyjahojRjTeLhFD+vt0YTNwkV8NSLi0Aak8SwhUtU4RwXgxCyLm8dLwtchNbR+cfg1fJq8/OoIrAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788660; c=relaxed/simple;
	bh=VhIuPn5J4RX2MPcrM7kGhhNAtmnlyh7bh6LqlilWRRE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=now43UKy3Pif1QPM7Rb0lvMFpycpQ8Gn6LgPE9mYP9+tMDtAxrYbxdcSYj6ckVab8Utty1ye6Bx4x5QPABKTyRB5LIS2dbovTgBXQuFDSYyv5LaT0GSqd5P78Gs9day6ewhhhwTNEPEGalOpeGL/UGM2rVLFbUHhxRuIuSYBCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFhG8ldh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFhG8ldh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2249CC32782;
	Fri, 16 Aug 2024 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723788660;
	bh=VhIuPn5J4RX2MPcrM7kGhhNAtmnlyh7bh6LqlilWRRE=;
	h=Date:From:To:Cc:Subject:From;
	b=mFhG8ldhAg77yTOx5axycm8U9RgekECXifUq//zFhWE2rpo5+sAYd+ydMq6Zkmq7W
	 GOQrcy12qF65gzstOsikHtoUepmRpjHlXRnV96PSJTrST/rx9ZYarO2enX0Vw9qdZ+
	 UE8lhHo+iI8+btewNqbl3YRfHffqK30YcorLWSgP4NRNOhvVYIdvRJkoEuh4uyPLKM
	 v0uDVuTzruaFew1vTlThFelMcZ1cpcUui64MyUOWeC746olV8vFvxeX5ydPMKDyeqA
	 9hxTl4sLVCJp3rdMWSNz0JVmKLuc9/3IxTFsuy6CdL8vfs7aU1nwUZpGC7nUCFqYLE
	 1KWdV7n2WSHIw==
Date: Fri, 16 Aug 2024 11:40:50 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, takakura@valinux.co.jp
Subject: [PATCH rcu 0/4] RCU stall updates for v6.12
Message-ID: <20240816061050.GA46994@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This series contains following RCU stall updates for v6.12:

1. Abbreviate RCU CPU stall warnings during CSD-lock stalls, courtesy of
   Paul E. McKenney.

2. Allow dump_cpu_task() to be called without disabling preemption,
   courtesy of Ryo Takakura.

Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=rcustall.15.08.24a
(rebased on top of csd.lock.15.08.24a because of commit dependency on commit ac9d45544cd5 "locking/csd_lock:
 Provide an indication of ongoing CSD-lock stall")


- Neeraj


Paul E. McKenney (3):
  rcu: Summarize RCU CPU stall warnings during CSD-lock stalls
  rcu: Extract synchronize_rcu_expedited_stall() from
    synchronize_rcu_expedited_wait()
  rcu: Summarize expedited RCU CPU stall warnings during CSD-lock stalls

Ryo Takakura (1):
  rcu: Let dump_cpu_task() be used without preemption disabled

 .../admin-guide/kernel-parameters.txt         |   4 +
 kernel/rcu/tree_exp.h                         | 113 ++++++++++--------
 kernel/rcu/tree_stall.h                       |   8 +-
 kernel/sched/core.c                           |   2 +-
 4 files changed, 74 insertions(+), 53 deletions(-)
