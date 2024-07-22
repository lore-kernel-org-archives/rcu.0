Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8E1D696;
	Mon, 22 Jul 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655367; cv=none; b=J22GneOUiXcnRweyzoiTbAKQ524mnrkPFutb5yuJA7mHOQojI/FZjc6L44tl5qeay5ENEctM//DQnXbkmFmGXs9FqQNIpAcTTHh7DW/cZLr9tlONTCXlkQKR90Eka5sqacSZSuvuz0f8Qm4pQoZrkGPxdLtoBVlv/NhyXH3QaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655367; c=relaxed/simple;
	bh=MBcKMmj///koLCjVVpBkTwdG8B4gnhcwZgCVB6UeiGg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rwJlr/ir4sfFiwBMD4BG0ClgEqnf5Jd5S6/dn7Pt4kwrFvdTM6VViPw8TfKNaPC9HKjs0RCMzJcS4TfL0yb/AIJomxT8Quud7a2sB+xSzDxyXFK3nTwRlWQVerpBDPmVN0TKLxjX5VeIrLp7BVuXEtL8j8FV0HQ29KEGTHOnMMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ9WrF6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ9WrF6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DFBC116B1;
	Mon, 22 Jul 2024 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721655366;
	bh=MBcKMmj///koLCjVVpBkTwdG8B4gnhcwZgCVB6UeiGg=;
	h=Date:From:To:Cc:Subject:From;
	b=AZ9WrF6IP0QvO0SBo1dPHmmJH54w04o8BAi71Gte5a6VK2oMFaV7oZZLLTMQTyXJr
	 Z5bOy0sZFOI5SFXJTCjIy4dgHXkTC8cLnl5WK7kT4ICEBTK4HDWGILfnSBG3UkrDiJ
	 ZiifoE+oyvCrMb2A9+1+3OH75MVLnqrszM31YUGstN2aqWQLt1ga+9nMDcZzbHZShi
	 QHOS6YRd+qLCV9mhuaF+LaEN3tPRNaYlJRChngufg8RMFOxb9O5B/A4z/ax0Iv/OBM
	 soFiSDeRprhQfR7HdXL9g4NI72diRQiJNf65lofRHS7PCt2lNPn/fVxkOK0ridoYaW
	 CpFRWrqi/QYvQ==
Date: Mon, 22 Jul 2024 19:05:59 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, paulmck@kernel.org,
	rostedt@goodmis.org, kernel-team@meta.com, leobras@redhat.com,
	imran.f.khan@oracle.com, riel@surriel.com, rcu@vger.kernel.org,
	neeraj.upadhyay@kernel.org, tglx@linutronix.de
Subject: [PATCH v2 0/3]  CSD-lock diagnostics enhancements
Message-ID: <20240722133559.GA667117@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series adds following changes to the CSD-lock diagnostics (rebased on v6.10):

1.      locking/csd_lock: Print large numbers as negatives.

2.      locking/csd_lock: Provide an indication of ongoing CSD-lock stall.

3.      locking/csd-lock: Use backoff for repeated reports of same
        incident.

This is the second version of this patchset. Previous version can be found at [1]

Changes since v1:
- Rebase on v6.10
- Fix n_csd_lock_stuck atomic op in csd_lock_wait_toolong (Rik van Riel)
- Apply Rik van Riel's Reviewed-by.

Once reviewed/acked, current plan is to take this through RCU tree during v6.12 merge window,
as RCU commit "7d2ba698ad85 rcu: Summarize RCU CPU stall warnings during CSD-lock stalls" [2]
has dependency on these changes. If there are any concerns with taking these through RCU tree,
please raise those concerns.



[1] https://lore.kernel.org/lkml/20240713165642.GA215331@neeraj.linux/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=rcustall.13.07.24a&id=7d2ba698ad85984656e9732d87b8e040a23baa55

Thanks
Neeraj

------------------------------------------------------------------------

 include/linux/smp.h |  6 ++++++
 kernel/smp.c        | 30 +++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)
