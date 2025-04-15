Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812D82DFA58;
	Tue, 15 Apr 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739976; cv=none; b=MWi8niPJM48NrxrivUaCy3QNmTklUvrhougjDI+0taP0JCDDL+vRAKE8efcPfNK3ZKIJDWVJ4H01Jsw8yXYNiLMl+M6AMrv4zt5D4hV6xa8KZdcw5Gnr0pPuMlBMueAzzEFl1mgr5g+lM4a26+gfOo1KCYDryQd3wYK6Xg8oVPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739976; c=relaxed/simple;
	bh=VoIyaU4Hw6jEgy4prndlDCy4P9hOYtAM/v/XpV9SaeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zme6d2NfD0tLTBHFOi2lqLUMUZnLCJASScVo0ZKQx3NNH2NdzlC5nSSp1dRrAyIcqzwV7xUZNRHt1AeyWNOfq+MGtDb9rdpc8G8ly0GPG6Fxz6PsWMyFfRfUaBwdWBSsVPDVVTe/eva4LPWUWSVtAsSi8OrPxk4n6W/mZK/2RQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GS/4OShG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GS/4OShG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F5EC4CEE9;
	Tue, 15 Apr 2025 17:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744739976;
	bh=VoIyaU4Hw6jEgy4prndlDCy4P9hOYtAM/v/XpV9SaeE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GS/4OShGRkW8azwjqrGiSIQipPcP2tGNzXsqNu2rvMkUd7ZCnM5QqMVmRdLjKbXHT
	 zzzFtNAyNfJyru4resdLBy62cNEtIHir6kg52Vmf5wjJN+1wj8mLD86/YMPdKYP5cn
	 Kur1vpRQAYDgnucBuPK+gz6DGBzF2eDKBSJflHcLrLOqo57di2ABtg/p9wN1zzSpO8
	 ZmH3i4GpS4vxRMyKSohywmW3Wba9MUmnkiODX3QFvVn86eZdHPAN10obDw7MiNgjXf
	 XNdM12s0vOv1BnCHG8vv7ZGq270/DDd6KjjwUHumJs1RtdoKNb2pbxES6wEzVQUS5o
	 wxIWGIebwmHSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 14603CE04F2; Tue, 15 Apr 2025 10:59:36 -0700 (PDT)
Date: Tue, 15 Apr 2025 10:59:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH v2 05/12] rcutorture: Add tests for SRCU up/down reader
 primitives
Message-ID: <37400faf-8d31-44ef-b9d1-6c91fa19b4f3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eea8d42f-6d2d-485b-9bb9-4eb77a0e1f95@paulmck-laptop>
 <20250331210314.590622-5-paulmck@kernel.org>
 <d40885a0-b0e3-4f13-a2b3-41ee2defbde0@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40885a0-b0e3-4f13-a2b3-41ee2defbde0@nvidia.com>

On Tue, Apr 15, 2025 at 01:16:15PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/31/2025 5:03 PM, Paul E. McKenney wrote:
> > This commit adds a new rcutorture.n_up_down kernel boot parameter
> > that specifies the number of outstanding SRCU up/down readers, which
> > begin in kthread context and end in an hrtimer handler.  There is a new
> > kthread ("rcu_torture_updown") that scans an per-reader array looking
> > for elements whose readers have ended.  This kthread sleeps between one
> > and two milliseconds between consecutive scans.
> > 
> > [ paulmck: Apply kernel test robot feedback. ]
> > [ paulmck: Apply Z qiang feedback. ]
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> For completeness, posting our discussion for the archives, an issue exists in
> this patch causing the following errors on an ARM64 machine with 288 CPUs:
> 
> When running SRCU-P test, we intermittently see:
> 
> [ 9500.806108] ??? Writer stall state RTWS_SYNC(21) g18446744073709551218 f0x0
> ->state 0x2 cpu 4
> [ 9515.833356] ??? Writer stall state RTWS_SYNC(21) g18446744073709551218 f0x0
> ->state 0x2 cpu 4
> 
> It bisected to just this patch.

Looks like your getting rcutorture running on ARM was well timed!

							Thanx, Paul
