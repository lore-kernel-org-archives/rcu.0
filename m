Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDD53F9F9
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 20:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560918; cv=none; b=sz3Qotw3sQNj9IYbsJ6iqq5Gyj65jm66yGDdZm2A/nviMYA77X9hbfN5fu/4ENOeGzxgmRCm4UgjfPST/uGzTzIFyALBEoESSCc9szrxcE7mRQDRAlcRObjuQryi/EaRTl1ONiNStUe0iL4GPnWwkX486si0OD9nCRhnavGS55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560918; c=relaxed/simple;
	bh=SQFIUIgsTpWGt0WuY1kdPhoHJ4Ud+X6qbp7lKZPjOB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSDrZCbC9qx6SsyxIbzZu5n7rXlY4WrnOpfKlbv3vjNAdnqHZLVAQMIdRdNqVV5cBl0AbWkq/aFRwYKL0J8uUAGgbvFl7NAC2r4KYQmEDO8rpWm4GgtM7s6R+AuwA3ofEGb5IwxnYzjIGgqfPuh8GrSl/DWyZ2l4Z6+1bgCq6jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNXrYxHh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNXrYxHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD29C433C7;
	Mon, 29 Jan 2024 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560918;
	bh=SQFIUIgsTpWGt0WuY1kdPhoHJ4Ud+X6qbp7lKZPjOB8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KNXrYxHhhcjpHkUGn4tmRSMAEReJnDi6Xy7a7QKOsZDFhZRzZwRKet1AOkWU4JBvd
	 VuBjpn/RShrLur875N5tThrDe4usegXNR5cZR6nuMMgr/fm9m9PcBSYceOv7fh0Aiq
	 WaVcA0fFX/3GyKz7NQ+QwcsKWOejFNu/NBd12iI1/K88c5hQ9CzuZRhWwsbaAC8fPY
	 LtEYNPmvKleC3R8bFQHpYv6u8kgmhJvY8XF/52IHVoWIQd0fYadCGyVNn9g/h1woIm
	 Qczt5g65UGD2Rl+LZpqQQhHZBu76DGTmPU6dyNnMQfFZqTiBK+TsAAKAHl56z2RCG2
	 W+bNiDqal5H0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B750FCE0B02; Mon, 29 Jan 2024 12:41:57 -0800 (PST)
Date: Mon, 29 Jan 2024 12:41:57 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelaf@google.com>
Cc: rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>

On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
> Hi Guys,
> Something caught my eye in [1] which a colleague pointed me to
>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
> 
> The test in concern is:
> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
> 
> which is a CPU intensive test.
> 
> Any thoughts on what else can attribute a 30% performance increase
> versus non-nohz_full ? (Confession: No idea if the baseline is
> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
> nohz_full on some of our limited-CPU devices :)

The usual questions.  ;-)

Is this repeatable?  Is it under the same conditions of temperature,
load, and so on?  Was it running on bare metal or on a guest OS?  If on a
guest OS, what was the load from other guest OSes on the same hypervisor
or on the hypervisor itself?

The bug report ad "CONFIG_HZ=250 : 17415.60 bogo ops/s", which makes
me wonder if someone enabled some heavy debug that is greatly
increasing the overhead of the scheduling-clock interrupt.

Now, if that was the case, I would expect the 250HZ number to have
three-quarters of the improvement of the nohz_full number compared
to the 1000HZ number:

17415.60-14866.05=2549.55
18505.52-14866.05=3639.47

2549.55/3639.47=0.70

OK, 0.70 is not *that* far off of 0.75.  So what debugging does that
test have enabled?  Also, if you use tracing (or whatever) to measure
the typical duration of the scheduling-clock interrupt and related things
like softirq handlers, does it fit with these numbers?  Such a measurment
would look at how long it took to get back into userspace.

I will let you do the algebra to work out the expected duration that
would be consistent with this hypothesis.  ;-)

							Thanx, Paul

> Cheers,
> 
>  - Joel
> 
> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2051342
