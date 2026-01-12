Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000534EF02;
	Mon, 12 Jan 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236523; cv=none; b=i9gP6rwtDNyL7eVHnZp2Qf+9TMkGrd/h/5T++FmIjLrhkMaBosuaaRsysyBnMJDgksq0RFzpR0dyMSVpNJq3B927dtxbBx+h7jI/q/sw9yY5OnBtY8xs9nM2gsXEJbdqNtg20Z6AXXLQGczEhYvoxc+n92+a8wvnXEMidRBcsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236523; c=relaxed/simple;
	bh=A2iGetTYYkirW+wtghq8g3RwESKxM7fo/vRP7+4LE78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq1NINF7AjEniymono4pWhY9H3TXdczcLE+C/OOwWva0OOemG6kF5hyReYp5UmMcr4kpX4iR6oyioyzaz3ViO9Efsqy5QkTBqhWDRwRgV0MnOYj7SK/CGRnlRFPvmZsTixhfNQym3P9AR+TKYEWd5WOG/fPjPV9HrTteIX8jX48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdZd0iHO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdZd0iHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE12C116D0;
	Mon, 12 Jan 2026 16:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768236522;
	bh=A2iGetTYYkirW+wtghq8g3RwESKxM7fo/vRP7+4LE78=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MdZd0iHOz1lBqr1/vmh88oA1tnBeU+UAZfVwDHCmWD9+EV/vuTHB2YaaHWWzzBjQ6
	 gKsSE3rJR7vLiObZNlYzTuGUmJr5k0SQU2fW3C6RGrARwcTxASBP6NU8ywYDNMFJXF
	 pM4Qgu9n8eU2xFo7bsj32RSuYVNOJa48LX/gS1NhricHc8wMMNzLa7uo1VcVRqHXzl
	 90mIz9I4RLBaxoG/hT0moAUB1cITszVIYK25s2ikE/2+lr0YzOmzgsEG+7FKrgb56+
	 qfLpXi/usPmDCvnJzI0/yns+Fe3LRyoTGLUfFtZPO7GZ3Pp3Q1u8F2sbsCW0HawjWJ
	 K+4qrplkznPvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 49A22CE083E; Mon, 12 Jan 2026 08:48:42 -0800 (PST)
Date: Mon, 12 Jan 2026 08:48:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"frederic@kernel.org" <frederic@kernel.org>,
	"neeraj.upadhyay@kernel.org" <neeraj.upadhyay@kernel.org>,
	"josh@joshtriplett.org" <josh@joshtriplett.org>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"srikar@linux.ibm.com" <srikar@linux.ibm.com>
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>

On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> 
> 
> > On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿Hello, Shrikanth!
> > 
> >> 
> >>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> >>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> >>>> Bulk CPU hotplug operations—such as switching SMT modes across all
> >>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> >>>> systems, this process takes significant time, increasing as the number
> >>>> of CPUs grows, leading to substantial delays on high-core-count
> >>>> machines. Analysis [1] reveals that the majority of this time is spent
> >>>> waiting for synchronize_rcu().
> >>>> 
> >>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >>>> operation. Since CPU hotplug is a user-initiated administrative task,
> >>>> it should complete as quickly as possible.
> >>>> 
> >>>> Performance data on a PPC64 system with 400 CPUs:
> >>>> 
> >>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >>>> Before: real 1m14.792s
> >>>> After:  real 0m03.205s  # ~23x improvement
> >>>> 
> >>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >>>> Before: real 2m27.695s
> >>>> After:  real 0m02.510s  # ~58x improvement
> >>>> 
> >>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> >>>> 
> >>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> >>>> 
> >>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> >>> your "expedited switch" improvement.
> >>> 
> >> 
> >> Hi Uladzislau.
> >> 
> >> Had a discussion on this at LPC, having in kernel solution is likely
> >> better than having it in userspace.
> >> 
> >> - Having it in kernel would make it work across all archs. Why should
> >>  any user wait when one initiates the hotplug.
> >> 
> >> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
> >>  though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
> >>  We will have to repeat the same in each tool.
> >> 
> >> - There is already /sys/kernel/rcu_expedited which is better if at all
> >>  we need to fallback to userspace.
> >> 
> > Sounds good to me. I agree it is better to bypass parameters.
> 
> Another way to make it in-kernel would be to make the RCU normal wake from GP optimization enabled for > 16 CPUs by default.
> 
> I was considering this, but I did not bring it up because I did not know that there are large systems that might benefit from it until now.

This would require increasing the scalability of this optimization,
right?  Or am I thinking of the wrong optimization?  ;-)

							Thanx, Paul
