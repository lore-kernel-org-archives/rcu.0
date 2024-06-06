Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3E198E88;
	Thu,  6 Jun 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717692600; cv=none; b=WwOaUKXeclN9obyHduYSEO/bmQ6JeTpEMbXabr1dTo5xu6dpyjMm1/AU53yr9QBp4C7gR/pO2VmaD25DbJfp48aemIAgU8HrGGSYFJxwmplUcarDUYusiEzgnhExKdjZ8xEtl9W9AdKBof6F6GVrZpVJ1CJNt6VVcIpYeCF6F8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717692600; c=relaxed/simple;
	bh=Hg4pytPcshJ5Vzw0x241oxxxQys6HoLuHWw6mFPLn8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWhIiDaJuuBVMT6fRHBFGdV6YI37uyHdb+RLz2Fjf3x4ZpjL7O45oQvtSK/TEgbyHpOSNN49XobWUg7IOQrk/zAfJ0jcFN3IVNQS1VZ3+zdJKqToFrGPlfmrpbkD3gQYqra1+P/dbdvMnvdEL7vy8G2E6yG6Ehva37+eP8T2VqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3yfbXCA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3yfbXCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED54DC2BD10;
	Thu,  6 Jun 2024 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717692600;
	bh=Hg4pytPcshJ5Vzw0x241oxxxQys6HoLuHWw6mFPLn8E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=e3yfbXCAXuC3R6OV8jc4OSsJCSGMdLDXIpC9Mg5QkQkblbPsf/ViCa/8PdzjmhzBN
	 e9hVL3PeCaJCFkn00KUNpywqYQhDaXS1WOTriYDioxkcEI4cpbEaL2aiSzEq72MqQR
	 CTrlnQ1RQKL5rI+kqUL8zSTJkVz6mF+P11dl+XpVOnSh/m1nR/z79qUID/TEZaJzT+
	 zfhYkqgAmlnbbNWZu9wAtkxJzMBfMYeb5y1aZSRUsvPMTmdkxm1GeSSSHfU9y3JNX1
	 MOZP8/42JlzXe2uy5WxvHNn9D+HDxzDGtakyXjG0Z0gAAUu8LSoYgq/xO1XBRLW6HU
	 LOzr8KkKPkzYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88570CE3F34; Thu,  6 Jun 2024 09:49:59 -0700 (PDT)
Date: Thu, 6 Jun 2024 09:49:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 2/9] rcu: Reduce synchronize_rcu() delays when all
 wait heads are in use
Message-ID: <a0aa3d5e-006c-475d-bd2f-b15fca47deee@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-2-paulmck@kernel.org>
 <ZmBVfpyEZeTIAHJn@localhost.localdomain>
 <c7d07e5d-34a0-4874-8e7e-1c576c14c8e6@paulmck-laptop>
 <fbc30c3a-ecd3-4525-9434-307c7769bb4c@amd.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbc30c3a-ecd3-4525-9434-307c7769bb4c@amd.com>

On Thu, Jun 06, 2024 at 09:16:08AM +0530, Neeraj Upadhyay wrote:
> 
> 
> On 6/6/2024 12:08 AM, Paul E. McKenney wrote:
> > On Wed, Jun 05, 2024 at 02:09:34PM +0200, Frederic Weisbecker wrote:
> >> Le Tue, Jun 04, 2024 at 03:23:48PM -0700, Paul E. McKenney a écrit :
> >>> From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> >>>
> >>> When all wait heads are in use, which can happen when
> >>> rcu_sr_normal_gp_cleanup_work()'s callback processing
> >>> is slow, any new synchronize_rcu() user's rcu_synchronize
> >>> node's processing is deferred to future GP periods. This
> >>> can result in long list of synchronize_rcu() invocations
> >>> waiting for full grace period processing, which can delay
> >>> freeing of memory. Mitigate this problem by using first
> >>> node in the list as wait tail when all wait heads are in use.
> >>> While methods to speed up callback processing would be needed
> >>> to recover from this situation, allowing new nodes to complete
> >>> their grace period can help prevent delays due to a fixed
> >>> number of wait head nodes.
> >>>
> >>> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> >>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>
> >> IIRC we agreed that this patch could be a step too far that
> >> made an already not so simple state machine even less simple,
> >> breaking the wait_head based flow.
> > 
> > True, which is why we agreed not to submit it into the v6.10 merge window.
> > 
> > And I don't recall us saying what merge window to send it to.
> > 
> >> Should we postpone this change until it is observed that a workqueue
> >> not being scheduled for 5 grace periods is a real issue?
> > 
> > Neeraj, thoughts?  Or, better yet, test results?  ;-)
> 
> Yes I agree that we postpone this change until we see it as a real
> problem. I had run a test to invoke synchronize_rcu() from all CPUs
> on a 96 core system in parallel. I didn't specifically check if this
> scenario was hit. Will run RCU torture test with this change.

Very well, I will drop this patch with the expectation that you will
re-post it if a problem does arise.

							Thanx, Paul
