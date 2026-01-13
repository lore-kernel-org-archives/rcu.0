Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02F72627;
	Tue, 13 Jan 2026 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262497; cv=none; b=tOV59YfJfV8w1VHR01V1+1GaT2jI1Wfg7gEsgPpjVXbp+hj604L4m/naNqi3GIVU+xPUqAyb2BkkJ/tYaHqEDhqx2WYtwBN77a1uaLQ5cZzqPZA/ZiWEJYwyaW7FeL9uy1Ss4PhUp54mPNde8GWb8yn7SugZiKtNgo34qZTwjaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262497; c=relaxed/simple;
	bh=kUFjqaHnXvIR3J7jt6BSSZlSkIZlU1H1XWcCnaL6TWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDgKcCsmwMdgERkHBv9XkwB8nSl4TOzcsI8ys9vhkhk2QToyRAGd7flXR+apUD0NStH0KzzzFIiwFFtHOhfqymXyoNFovqJY2FBVJ2U73jdBfxZuwtrh+hyjGutPHmBm5Fs04Y0/JrLUvHmF9KBapbLPWdT75lvdzwJ5+bCnBfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCWmFXo/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCWmFXo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0510BC116D0;
	Tue, 13 Jan 2026 00:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768262497;
	bh=kUFjqaHnXvIR3J7jt6BSSZlSkIZlU1H1XWcCnaL6TWQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gCWmFXo/qXy7BTVQVWhQkaGyVYOG7IHhp+3CHhISN11I3fUP9Y3fEruEdomYxpVqa
	 aYk7ZAZ4fNFEmi2JAvVWJvbtz0q2M7xJxVYMJiLvkUBb00yAzkYTjxaJ/3JAnUyTIV
	 TuX6UVEafZiIS+sEvc9qsUIMYAVvOxoge0tz5UhU1qk4vwimpla+uncsYG8f4ptwaB
	 +CPnbDuWmHIh/k63a7fiEUSf4BcEZsYuPaLnzBwrdiaJyzMF4nkwV0SvK3ZrFo2orf
	 K4RSV0gRKaqA5rP5IKgaUcKujCzV9sbvchHc+HSNAChLCWo/qjU4diy6goRKuzSa1e
	 NXKsZVE7UUi6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7F5FBCE0A3C; Mon, 12 Jan 2026 16:01:36 -0800 (PST)
Date: Mon, 12 Jan 2026 16:01:36 -0800
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
Message-ID: <dc19d6d4-bfe9-479a-8d3e-e587fbc89465@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <aWTIDGQ1_NYeO4iU@pc636>
 <5a2b00f2-5e73-4c89-89b5-1a69cb8a7fa2@linux.ibm.com>
 <aWTvtVGe8un5xtTn@milan>
 <91138C31-EF47-4CA6-BD9F-A41981F543EE@nvidia.com>
 <05e31c43-02b5-4c3d-8a11-3cb7987cfa0c@paulmck-laptop>
 <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3525b8af-7e14-44e4-a909-ad46a0764d94@nvidia.com>

On Mon, Jan 12, 2026 at 05:24:40PM -0500, Joel Fernandes wrote:
> 
> 
> On 1/12/2026 11:48 AM, Paul E. McKenney wrote:
> > On Mon, Jan 12, 2026 at 04:09:49PM +0000, Joel Fernandes wrote:
> >>
> >>
> >>> On Jan 12, 2026, at 7:57 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>
> >>> ﻿Hello, Shrikanth!
> >>>
> >>>>
> >>>>> On 1/12/26 3:38 PM, Uladzislau Rezki wrote:
> >>>>> On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> >>>>>> Bulk CPU hotplug operations—such as switching SMT modes across all
> >>>>>> cores—require hotplugging multiple CPUs in rapid succession. On large
> >>>>>> systems, this process takes significant time, increasing as the number
> >>>>>> of CPUs grows, leading to substantial delays on high-core-count
> >>>>>> machines. Analysis [1] reveals that the majority of this time is spent
> >>>>>> waiting for synchronize_rcu().
> >>>>>>
> >>>>>> Expedite synchronize_rcu() during the hotplug path to accelerate the
> >>>>>> operation. Since CPU hotplug is a user-initiated administrative task,
> >>>>>> it should complete as quickly as possible.
> >>>>>>
> >>>>>> Performance data on a PPC64 system with 400 CPUs:
> >>>>>>
> >>>>>> + ppc64_cpu --smt=1 (SMT8 to SMT1)
> >>>>>> Before: real 1m14.792s
> >>>>>> After:  real 0m03.205s  # ~23x improvement
> >>>>>>
> >>>>>> + ppc64_cpu --smt=8 (SMT1 to SMT8)
> >>>>>> Before: real 2m27.695s
> >>>>>> After:  real 0m02.510s  # ~58x improvement
> >>>>>>
> >>>>>> Above numbers were collected on Linux 6.19.0-rc4-00310-g755bc1335e3b
> >>>>>>
> >>>>>> [1] https://lore.kernel.org/all/5f2ab8a44d685701fe36cdaa8042a1aef215d10d.camel@linux.vnet.ibm.com
> >>>>>>
> >>>>> Also you can try: echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> >>>>> to speedup regular synchronize_rcu() call. But i am not saying that it would beat
> >>>>> your "expedited switch" improvement.
> >>>>>
> >>>>
> >>>> Hi Uladzislau.
> >>>>
> >>>> Had a discussion on this at LPC, having in kernel solution is likely
> >>>> better than having it in userspace.
> >>>>
> >>>> - Having it in kernel would make it work across all archs. Why should
> >>>>  any user wait when one initiates the hotplug.
> >>>>
> >>>> - userspace tools are spread across such as chcpu, ppc64_cpu etc.
> >>>>  though internally most do "0/1 > /sys/devices/system/cpu/cpuN/online".
> >>>>  We will have to repeat the same in each tool.
> >>>>
> >>>> - There is already /sys/kernel/rcu_expedited which is better if at all
> >>>>  we need to fallback to userspace.
> >>>>
> >>> Sounds good to me. I agree it is better to bypass parameters.
> >>
> >> Another way to make it in-kernel would be to make the RCU normal wake
> >> from GP optimization enabled for > 16 CPUs by default.>>
> >> I was considering this, but I did not bring it up because I did not
> >> know that there are large systems that might benefit from it until now.>
> > This would require increasing the scalability of this optimization,
> > right?  Or am I thinking of the wrong optimization?  ;-)
> > 
> Yes I think you are considering the correct one, the concern you have is
> regarding large number of wake ups initiated from the GP thread, correct?
> 
> I was suggesting on the thread, a more dynamic approach where using
> synchronize_rcu_normal() until it gets overloaded with requests. One approach
> might be to measure the length of the rcu_state.srs_next to detect an overload
> condition, similar to qhimark? Or perhaps qhimark itself can be used. And under
> lightly loaded conditions, default to synchronize_rcu_normal() without checking
> for the 16 CPU count.
> 
> Thoughts?

Or maintain multiple lists.  Systems with 1000+ CPUs can be a bit
unforgiving of pretty much any form of contention.

							Thanx, Paul
