Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668E306B02;
	Fri, 16 Jan 2026 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590150; cv=none; b=jQEbIX1Evp6BuTdLzNlu+gyArFjQviaGUAhgCynsGf9RIDQUuDa85wXkvU47yI6cIDgjtiQzBNLCCE1vNImnMegCjrUusPp1zvrgPk3d80A/QXWoAG0WGluGUj0hUt/z5vfmPcbhIJ3ukaF95OwHGWuJ9NXivXU57Sq6R4yQpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590150; c=relaxed/simple;
	bh=yEHmiAV0iB7jdtGOKSvVytzuPrdZi7FSXsSLEBc7sPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKz7ZtbC0cXJfootxZ+eq5/wUAGV8cC8XKgIU5xtLe2/hUW2uqEat3kLPtHvxm73mysbpgV/LgoOaeSORarJEqbzN4g0Wv7jA29L52aAoHqWiOII/Av/VsYkzljHoIjh89E6C+ZQAStZbtm3XOdcdg9yMaWs+BdmM0L6L3m0iak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7DqQ1Em; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7DqQ1Em"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3EDC116C6;
	Fri, 16 Jan 2026 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768590150;
	bh=yEHmiAV0iB7jdtGOKSvVytzuPrdZi7FSXsSLEBc7sPI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=D7DqQ1EmzOPBRNrYWMp5HqwdElUOtG/jNmiP1lwo5zbMR+hvZdnFwvH0t+U/sJHdY
	 x+A/j4YPJfN0hZYf2Y9uyntkdgnsxpBi+oflF4vp6y10vPG307xxBlLZdzWV41DUFC
	 +EX4qvSNkcgzaNlVtQLIMQf6OhPrh6nL2vH+sEG+GE5/JW3GU2dKo+4IGZFrkClt7I
	 i6K5uwoOv6p97SH9yUFqJryD8+MI9Qhl+O27iujmrTGmdLF8p5reZiIjuK9AVsXkn8
	 6JwiF2iAaFGkL2CGjRvl4Xt59vB3I9YyjqKshMAcwLaeT1EExjKdCSoVAh9F1e04bd
	 prp12gPQpM6gQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DA170CE0CFD; Fri, 16 Jan 2026 11:02:29 -0800 (PST)
Date: Fri, 16 Jan 2026 11:02:29 -0800
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
Message-ID: <5e11a34a-29c2-469a-a523-35aad71943bd@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
 <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
 <DBFC3146-10CD-466F-8209-11F8F0CAC19F@nvidia.com>
 <97bc2b22-0ef6-4ac4-a7c8-0f7f4886cfe5@linux.ibm.com>
 <37372899-9CA4-455D-83EB-79A07294D34A@nvidia.com>
 <a0f38f55-01bd-4b0a-866a-3f213f6e7cd8@paulmck-laptop>
 <a1a6ae5b-6304-46f1-b29c-07dcf76fb747@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1a6ae5b-6304-46f1-b29c-07dcf76fb747@nvidia.com>

On Wed, Jan 14, 2026 at 03:54:44AM -0500, Joel Fernandes wrote:
> 
> 
> On 1/13/2026 11:00 PM, Paul E. McKenney wrote:
> > On Tue, Jan 13, 2026 at 08:57:20AM +0000, Joel Fernandes wrote:
> >>
> >>
> >>> On Jan 12, 2026, at 11:55 PM, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> >>>
> >>> ﻿Hi.
> >>>
> >>> On 1/13/26 8:16 AM, Joel Fernandes wrote:
> >>>
> >>>
> >>>>>>>> Another way to make it in-kernel would be to make the RCU normal wake
> >>>>>>>> from GP optimization enabled for > 16 CPUs by default.>>
> >>>>>>>> I was considering this, but I did not bring it up because I did not
> >>>>>>>> know that there are large systems that might benefit from it until now.>
> >>>>>>> This would require increasing the scalability of this optimization,
> >>>>>>> right?  Or am I thinking of the wrong optimization?  ;-)
> >>>>>>>
> >>>>>> Yes I think you are considering the correct one, the concern you have is
> >>>>>> regarding large number of wake ups initiated from the GP thread, correct?
> >>>>>>
> >>>>>> I was suggesting on the thread, a more dynamic approach where using
> >>>>>> synchronize_rcu_normal() until it gets overloaded with requests. One approach
> >>>>>> might be to measure the length of the rcu_state.srs_next to detect an overload
> >>>>>> condition, similar to qhimark? Or perhaps qhimark itself can be used. And under
> >>>>>> lightly loaded conditions, default to synchronize_rcu_normal() without checking
> >>>>>> for the 16 CPU count.
> >>>>>>
> >>>>>> Thoughts?
> >>>>>
> >>>>> Or maintain multiple lists.  Systems with 1000+ CPUs can be a bit
> >>>>> unforgiving of pretty much any form of contention.
> >>>> Makes sense. We could also just have a single list but a much smaller threshold for switching synchronize_rcu_normal off.
> >>>> That would address the conveyor belt pattern Vishal expressed.
> >>>> thanks,
> >>>>  - Joel
> >>>
> >>> Wouldn't that make most of the sync_rcu calls on large system
> >>> with synchronize_rcu_normal off?
> >>
> >> It would and that is expected.
> >>
> >>>
> >>> Whats the cost of doing this?
> >>
> >> There is no cost, that is the point right. The scalability issue Paul is referring to is the
> >> large number of wake ups. You wont have that if the number of synchronous callers is small.
> > 
> > Also the contention involved in the list management, if there is still
> > only the one list.
> > 
> Even if the number of synchronize_rcu() in flight is a small number? like < 10.
> To clarify, I meant keeping the threshold that small in favor of the list
> contention issue you're raising.

Maybe?

One remaining concern is the reads of the counter.  Another remaining
concern is the possibility of large numbers of CPUs reading the counter,
seeing that it is small, then all piling on the list.  But it looks
like you might get some testing on a large system, so nothing quite like
finding out.

If it breaks, you guys get to fix it on whatever schedule is indicated
at that time.  ;-)

							Thanx, Paul
