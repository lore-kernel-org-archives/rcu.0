Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335DC288514;
	Wed, 14 Jan 2026 04:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768363202; cv=none; b=d1X/Ql5Ktk1HSkEkBvGkh3pqwZBb6w/hfIJrVp3zOJsIpnq5y13+DXYw3NcGiH/EfH9bDMqChofeNbnWooMgAUmklcXehbEvWpFEnYBde9KOc5sUFUj69oTYly6OQLNgBQROYq1Q2CRPnF3Yw7azph0aH6iE2+sxKmwAzpIKBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768363202; c=relaxed/simple;
	bh=c+6ONg2jkNaCC/vwTmSXwePSjs1qNhzhGxnz+9MB4mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELOWcxKxV3oS6fRXWJ5/ht/IMJnNGkzSQAxvVWN1UMw9uRukxowS4NyTwD83Qk0L8WAOW7IfMlYwlHoJjUyNQy1xRIqiaOX9cQmc8k3xiLYhVCGA5laK1vIiSNBjOehw7xNXwZnJXuNVDXTd6/bBumb1V0/3nIWsg3zG2FR7Gso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kttl4WHD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kttl4WHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89192C4CEF7;
	Wed, 14 Jan 2026 04:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768363201;
	bh=c+6ONg2jkNaCC/vwTmSXwePSjs1qNhzhGxnz+9MB4mU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kttl4WHDJRNSPtJYTzNuhnl2dke9x0jen4HGHYaklmJNfIc7FvSkMF+5g+iUPczO7
	 ECWkyHYEaqvPfv/0awyY2a90/J1X1I6RRgA1fzRHI7eZJMNWXGJSDTW6itk9Z2Nb6x
	 s2rUumyNYcKUGY6PETb7Ix6vcUTggr3YjZuhWs7C2a4SjdxT0vJDC/hGJPNFvPUzWN
	 OI3u/zpB68O+6+YBZJnAxUyeGK+fSdzAA3zyProYSF8jlktF47gNr1JHtE/YYb5c1U
	 INuFANwLVDe/r0Lbemeukk27s3Bkp8oGxP/3S4eRzxN2ElVrLsbdif2CLtt90Pbwus
	 P1+JA4hD65pbA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 06E18CE0B7C; Tue, 13 Jan 2026 20:00:01 -0800 (PST)
Date: Tue, 13 Jan 2026 20:00:01 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <a0f38f55-01bd-4b0a-866a-3f213f6e7cd8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
 <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
 <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>
 <97bc2b22-0ef6-4ac4-a7c8-0f7f4886cfe5@linux.ibm.com>
 <37372899-9CA4-455D-83EB-79A07294D34A@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37372899-9CA4-455D-83EB-79A07294D34A@nvidia.com>

On Tue, Jan 13, 2026 at 08:57:20AM +0000, Joel Fernandes wrote:
> 
> 
> > On Jan 12, 2026, at 11:55 PM, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> > 
> > ﻿Hi.
> > 
> > On 1/13/26 8:16 AM, Joel Fernandes wrote:
> > 
> > 
> >>>>>> Another way to make it in-kernel would be to make the RCU normal wake
> >>>>>> from GP optimization enabled for > 16 CPUs by default.>>
> >>>>>> I was considering this, but I did not bring it up because I did not
> >>>>>> know that there are large systems that might benefit from it until now.>
> >>>>> This would require increasing the scalability of this optimization,
> >>>>> right?  Or am I thinking of the wrong optimization?  ;-)
> >>>>> 
> >>>> Yes I think you are considering the correct one, the concern you have is
> >>>> regarding large number of wake ups initiated from the GP thread, correct?
> >>>> 
> >>>> I was suggesting on the thread, a more dynamic approach where using
> >>>> synchronize_rcu_normal() until it gets overloaded with requests. One approach
> >>>> might be to measure the length of the rcu_state.srs_next to detect an overload
> >>>> condition, similar to qhimark? Or perhaps qhimark itself can be used. And under
> >>>> lightly loaded conditions, default to synchronize_rcu_normal() without checking
> >>>> for the 16 CPU count.
> >>>> 
> >>>> Thoughts?
> >>> 
> >>> Or maintain multiple lists.  Systems with 1000+ CPUs can be a bit
> >>> unforgiving of pretty much any form of contention.
> >> Makes sense. We could also just have a single list but a much smaller threshold for switching synchronize_rcu_normal off.
> >> That would address the conveyor belt pattern Vishal expressed.
> >> thanks,
> >>  - Joel
> > 
> > Wouldn't that make most of the sync_rcu calls on large system
> > with synchronize_rcu_normal off?
> 
> It would and that is expected.
> 
> > 
> > Whats the cost of doing this?
> 
> There is no cost, that is the point right. The scalability issue Paul is referring to is the
> large number of wake ups. You wont have that if the number of synchronous callers is small.

Also the contention involved in the list management, if there is still
only the one list.

							Thanx, Paul
