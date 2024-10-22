Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671941CCEFA
	for <rcu@vger.kernel.org>; Tue, 22 Oct 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729636859; cv=none; b=Z6Qi13zy3sHmgV6v868Gpc7mVI/nV6zUjpFSqofVhfrRru9BE1T7dJvBDAcewiJyugWYtNW0AUOEpRAV6dGWyCH9PuzzM1LJ9sPJt0gSVuVmMFZhtS5PGJ5dLm6zHQpIgqYiVF+t3eK19zxOwq6tJnPB5ynNkB6ob+2/vYFAKgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729636859; c=relaxed/simple;
	bh=eexersxQ+NEOz6YtwK353Vow/rNqyLkjECRCGfd1lj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJv/jXMln/H6uuOYbk1XjdDStRY7N9MuWqfbVa0gr8CilR4Vx+lZUU1eGTxkn/MpDyFp2Hh69+/WG4uwNkIh2UUr6GpODYEsQ7TSsBx8NpWc3lKjVNiMlQdvEhT6fkfjvWRZtz3C2ElMO+9iHafq+hKySBPOkyhzJZ07nJl/r3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp9hMs6E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp9hMs6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EB0C4CEC3;
	Tue, 22 Oct 2024 22:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729636859;
	bh=eexersxQ+NEOz6YtwK353Vow/rNqyLkjECRCGfd1lj0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Pp9hMs6En6u7w4b3UiOND7khPTPXtGifqJM+1Dg6REECYmzuibnwf2tFoeSD6QdZw
	 H3XiAriabW3tyDHyDLkdsVjfqVJrmr4g97JzXqaFF6Q218jDqP+JXv8o2puineC0a4
	 iqQJFNeNgjHmxb+P09qo+chyfIVUsm6XJX+EHOxjioxNaAWR9imaducUsQnPEMd3OQ
	 ON+Pj40bTNE+CPIoalZ9+e7VmRtyB6KD3iOZV4NS5srojjrE+rUcmuLckXhlf2dVSq
	 slXaHOvNKbCozPNQARhB1YIaFMfvmiEVAIiDuH63yz/RRDUPJPwQsN5r1Ky8Jdls4g
	 5bdJx20IqMaDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 95B0BCE0A48; Tue, 22 Oct 2024 15:40:58 -0700 (PDT)
Date: Tue, 22 Oct 2024 15:40:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shane Miller <gshanemiller6@gmail.com>
Cc: rcu@vger.kernel.org
Subject: Re: defer_rcu() usage
Message-ID: <1e65f9c6-0251-4ffd-a7de-aa83e7b40ec1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAFtQo5By2EjXrjzdmx=dEt9k+20EjEGuwdEAZ4fB3=8H37tp=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFtQo5By2EjXrjzdmx=dEt9k+20EjEGuwdEAZ4fB3=8H37tp=Q@mail.gmail.com>

On Tue, Oct 22, 2024 at 06:21:47PM -0400, Shane Miller wrote:
> I've used the qsbr flavor of urcu with success. It works great. The
> doc, benchmark code make clear that RCU writers,
> 
> * must use rcu_xchg_pointer() or rcu_assign_pointer() to update data structure
> * must call 'synchronize_rcu()' which blocks until readers are out of
> critical section on old copy so that the old data structure can be
> cleaned up.
> 
> However, synchronize_rcu() is not giving me the write performance I want.

Not surprising given that it is a synchronous primitive that blocks
until all pre-existing readers have completed.  It tends to be used in
cases where updates are infrequent, so that the latency is not an issue.

> But 'tests/benchmark/test_urcu_defer.c' does - cool!
> 
> Regrettably, the doc on 'defer_rcu' just isn't clear to me. When
> 'defer_rcu' runs the callback specified in its arguments can I
> conclude, like 'synchronize_rcu()' that there are no/none/zero readers
> in a critical section on the old data structure?

Yes.

> Is this the intended usage?
> 
> ```
> void deferCallBack(void *oldData) {
>  Foo *old = (Foo*)oldData;
>   // In this function I know for sure no RCU reader
>   // is in a critical section in 'old'. I can free/mutate
>   // it as needed
>   . . .
> }
> 
> void rcuWriterLoop() {
>   rcu_defer_register_thread();
>   while (!done) {
>     Foo *newCopy = ....
>     // Prior to this line readers are not in a read critical section (CS)
>     // or in CS on 'old'. On return readers are not in a CS or in
>     // a CS in newCopy only.
>     Foo *old = rcu_xchg_pointer(&current, newCopy);
>     // Cleanup 'old': readers can't be accessing it
>     defer_rcu(deferCallBack, old);
>   }
>   rcu_defer_unregister_thread();
> }
> ```

It looks plausible to me.

Another alternative that is useful when tearing down a data structure
is to make that data structure inaccessible to readers, invoke a single
synchronize_rcu(), then free up all the objects in that data structure.

							Thanx, Paul
