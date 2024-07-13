Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C521176FA3;
	Sat, 13 Jul 2024 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889810; cv=none; b=tFC2AQdFYhq7OqUxl0sVu6IVRSy1H66kR60QzMwpFjTiwMHrclLnqUhdj+Y5FxvqL3fVA28wurFW5UWyKwZiPpUYn3FsQm0kBXl6hI3tTUT7zm6NSo4LzwG6reHJiVNJha8e+nNA+hRrNq1VQCB4qRc5tGOzgllPgD9+WnNPmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889810; c=relaxed/simple;
	bh=A7IUNAQvKzjSzg3eUpbZWw9RBwbDJgv3zryAMGBKgp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mMovENX4qHOHASJyxYB9zizuvx3+dgoYW9g6V795Uk40YH5lLfQqcsuqeoiaH0KZtN5YkXktslejjdEVyk2FSRhawbEiL9Rc7qrx+eFcfPPUQ7GzGdPOjKJ5c1fGeSm/kLq8yHi6Vsc1uS+JXSlkx/iUrc+QDIlQ0KE+hCbHN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcqM4Cgm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcqM4Cgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF6DC32781;
	Sat, 13 Jul 2024 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720889809;
	bh=A7IUNAQvKzjSzg3eUpbZWw9RBwbDJgv3zryAMGBKgp0=;
	h=Date:From:To:Cc:Subject:From;
	b=WcqM4CgmkX7Wt39krTAuaW3llJIBADCbp8EhK524uqQGAcI9tSA2brzTfR/i1q6yB
	 deVS49c+zVLoTKfI603ulI22OR7Qbil4NQf/630Zt96wWQ3HVh0ja+6EEbEoBf9JTN
	 LfqXnnobxviEf37y4YTD3lon7t+DUTIRuhuCxxsR+qY6INF02aO0CW68ANXg19mcTL
	 kUfzBu8lLHMSYg4ACXZkPfAR8wAcCuapYsX1/pvqfVCzZV/T+Y1cU+n+AQru4PscbE
	 B+WkZDWS+xqL5ZTBniXmZ4q1vEMA0r/H+S7/07QFAMixORWK+sv2pgEo4MOB4ytMKY
	 KdxEvSkHhEHEg==
Date: Sat, 13 Jul 2024 22:26:42 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, paulmck@kernel.org,
	rostedt@goodmis.org, kernel-team@meta.com, leobras@redhat.com,
	imran.f.khan@oracle.com, riel@surriel.com, rcu@vger.kernel.org,
	neeraj.upadhyay@kernel.org
Subject: [PATCH 0/3]  CSD-lock diagnostics enhancements
Message-ID: <20240713165642.GA215331@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series adds following changes to the CSD-lock diagnostics (rebased on v6.10-rc7):

1.      locking/csd_lock: Print large numbers as negatives.

2.      locking/csd_lock: Provide an indication of ongoing CSD-lock stall.

3.      locking/csd-lock: Use backoff for repeated reports of same
        incident.

Once reviewed/acked, current plan is to take this through RCU tree during v6.12 merge window,
as RCU commit "7d2ba698ad85 rcu: Summarize RCU CPU stall warnings during CSD-lock stalls" [1]
has dependency on these changes. If there are any concerns with taking these through RCU tree,
please raise those concerns.



[1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=rcustall.13.07.24a&id=7d2ba698ad85984656e9732d87b8e040a23baa55

Thanks
Neeraj

------------------------------------------------------------------------

 include/linux/smp.h |  6 ++++++
 kernel/smp.c        | 30 +++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)
