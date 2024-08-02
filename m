Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342F1E3CA6
	for <rcu@vger.kernel.org>; Fri,  2 Aug 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722607090; cv=none; b=IHcIHDdCHXxxtzVw5jtowcsVhhfgLQjDRvOxzM2l51NOrLz6ZO42jWLwRlPzBTYCRro1IvCiF6EH0VUTeleH5XbfgXzU8Y3i9G/AZz9jhJgbqqd/eXqdHy9Cayctw6oZkiXc1qfKdX3vNhm4IEBkYwzdBCeq1buV/4Oc9R09yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722607090; c=relaxed/simple;
	bh=1CBPzpiefi6mi1eGObwPOrKLNPOkfXwo3TSkGQWRveQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/Il1ZYaeCqi9jr7J9reQAnB+VD7h6BNaRhsKps8XkrTkuEgPbAJpZ6vZaMfupglmWeJVARDWtLOwxcBhZE9SAIspGpk2HfB7LuB+bvCpjBPRMaawjkOa9v3atmkEv0akf7VhE/Pe627yuCDYtstma/ydveBC0lsEAhT4vI1z4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZKsikNQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZKsikNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88B2C32782;
	Fri,  2 Aug 2024 13:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722607089;
	bh=1CBPzpiefi6mi1eGObwPOrKLNPOkfXwo3TSkGQWRveQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AZKsikNQbYo7F3AitenYnMnQJ6vP/OMEnTi0RILvqVaFHIf9/6L4jDvv3XmOTmd+u
	 9mZEfV9T2WIO82UX+WRfrK7oTwi2MUP8H4tPhxQshVzIqBJO7yCWTzMqwYO26a4R3A
	 jOTWH0p3Esv+XEiNzk+G/h+i4eiT+cMsY0kIgeLMm9CZodi0mlkDoA43XD+8RCJsHc
	 yYpSBrOh+jAvf27OBBtHuXb1P3RQfI+IfOqJqjK5NASkaFPIvL8nhhh+ps360amXNs
	 AfGJ7V+ZxsSTbTuiRU2Au2Uf3TBKNJKAvAPu0GTZi4+eEZi+ev53mL5oXltZ2/B2oN
	 y/P2fbblC+4AA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 84DA8CE0D9A; Fri,  2 Aug 2024 06:58:09 -0700 (PDT)
Date: Fri, 2 Aug 2024 06:58:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Olivier Langlois <olivier@trillion01.com>
Cc: rcu@vger.kernel.org
Subject: Re: unexpected result with rcu_nocbs option
Message-ID: <383ce0ce-fe27-46a5-ac1e-2dd2ea2be4fe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6d3bb877aab5ac35c3b994596354fc28c8f4f95.camel@trillion01.com>
 <1b5bb521bc49347bf17789b50a3c4fa5e21891ad.camel@trillion01.com>
 <df1278ca-10c6-4687-bc86-ebb0293123ab@paulmck-laptop>
 <1684cb34f67618cff63b24da9864a23815e7f6e0.camel@trillion01.com>
 <dbb43d66fc1642d57c71d1908dd4513dda0d55bd.camel@trillion01.com>
 <358ab93d-7354-42cf-9498-0fc18a9d49d6@paulmck-laptop>
 <f7b2ea1fd826c502963d574e4c229de4427440a7.camel@trillion01.com>
 <70ef45ee-2547-496a-aed3-27cec933c671@paulmck-laptop>
 <560ef22942010a3f0ea4ad43e0dea048fe967369.camel@trillion01.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <560ef22942010a3f0ea4ad43e0dea048fe967369.camel@trillion01.com>

On Fri, Aug 02, 2024 at 09:46:03AM -0400, Olivier Langlois wrote:
> On Thu, 2024-08-01 at 20:01 -0700, Paul E. McKenney wrote:
> > 
> > Very good!!!
> > 
> > The do_nocb_deferred_wakeup_timer() is due to call_rcu() being
> > invoked
> > in a context where it might not be safe to do a wakeup().  RCU
> > doesn't
> > have a lot of choice in this situation, so the usual approach is to
> > figure out what is invoking call_rcu() on your nohz_full CPUs and to
> > make it run elsewhere.
> > 
> > I don't know what is happening with mix_interrupt_randomness().
> > 
> > 							Thanx, Paul
> there few more that are popping out like:
> 
> tsc_sync_check_timer_fn
> mce_timer_fn
> 
> but those 2 + do_nocb_deferred_wakeup_timer are not immediately
> generating an interrupt. Only mix_interrupt_randomness does because it
> adds an already timed out timer. So the CPU is kicked on insertion.
> 
> I have quickly looked at drivers/char/random.c
> 
> and there is no obvious way to address this that I can think of without
> causing potential serious side-effects...
> 
> but I really find mysterious that only 1 of my nohz_full cpus is
> impacted this...
> 
> and imho, this does not sound like a good idea to include interrupt
> randomness of a nohz_full cpu...
> 
> I think that I am going to throw down the towel of reaching the goal of
> 100% interrupt free for now. The amount of efforts required to reach
> the goal vs the diminishing result I can get is not a good deal. For
> now, I am going to tolerate this 27uSec interrupt once every 2-3
> seconds...
> 
> but I find this challenge very fascinating and I'll start to follow
> Brendan Gregg's blog to learn more about the field.
> 
> thank you very much for your assistance. I am leaving with an
> impression that the rcu dev list is very helpful and friendly!

Are you doing system calls on your worker CPUs?  If so, one
straightforward way to get rid of this is to make your application push
the system calls off to the housekeeping CPU.  Keep in mind that system
calls often need to defer work of one sort or another.

The real-time guys would know more about this sort of thing.

							Thanx, Paul
