Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E751494A8;
	Sun, 16 Mar 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742163851; cv=none; b=Ys0DgV8qeeH1n2Gy0BqYhSAssBJocZ2404JpvE7lb8SOtRNd+cCoYyj/YorYfuJ2+JNDIp1RXr93e1fcw+YOve/wmWpB6VgKt7KM1PdBXRqgZm7T0WwbmWHDxzzdw3wwWizvrJf5o3P3HYr4xnXAyzJ40NDjMv/Xnss0yN4jnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742163851; c=relaxed/simple;
	bh=bV5T7y1TIGUqZCJO8ytCSbp9dZeJhFc9mSDnxyUxb30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiSTyCQewmoOTmlBeEBvygYqD2WnLJYi+4J2fLNc0Owh9zGTQtf4LRlwvO1aHKpMYmFd/W67S7wTHN8b+bqTASDYLZZsxHBo+eDje5abqo9islUuhijz1asPEXtT1DT/QtFdG2tbdUZbJeNM+w3y565nLbbVsMUWWh8J4ZwlYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLCLanvx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLCLanvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AA9C4CEDD;
	Sun, 16 Mar 2025 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742163851;
	bh=bV5T7y1TIGUqZCJO8ytCSbp9dZeJhFc9mSDnxyUxb30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qLCLanvxAMqsZZ9G2f1JFcvm7suGlKnJ+AvkUDJkM4IzgXr5i1wBT0YpMw66YvXOX
	 6JQGhBsMHvXnbhjsHqiyL9H9vopEIZb4MBHzwhC36wx6oLm7a4pxvmtIoUYdZer9g6
	 uYdq8908RRfwGy9UxgCLpr8uqTdjkhJI/+OhVcc0LUhvyQeR0nYYWzmb9zNL0VWmrv
	 dlURoRNnqA6giRihBLR6ioAT6LQY7oE8/FhvWB4d+KTY4KQ1wWLq3scWKJYxjSQa7j
	 17knuRPjkx7zW+EqofLm3OU9qBc9sPBJNUP7sfwo9t0SxI+3lzh6A7uFH54PLZq1Gz
	 8g3KdPDgv8Fhw==
Date: Sun, 16 Mar 2025 23:24:08 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 1/5] rcu/exp: Protect against early QS report
Message-ID: <Z9dPiCVpxaX1aGEi@pavilion.home>
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-2-frederic@kernel.org>
 <20250315235945.GA2634509@joelnvbox>
 <Z9aw252VPvW9K4Wl@pavilion.home>
 <65d7e2db-2293-4fa5-ae73-bcbaa60c01f3@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65d7e2db-2293-4fa5-ae73-bcbaa60c01f3@nvidia.com>

Le Sun, Mar 16, 2025 at 10:23:45AM -0400, Joel Fernandes a écrit :
> >> A small side effect of this patch could be:
> >>
> >> In the existing code, if between the sync_exp_reset_tree() and the
> >> __sync_rcu_exp_select_node_cpus(), if a pre-existing reader unblocked and
> >> completed, then I think it wouldn't be responsible for blocking the GP
> >> anymore.
> > Hmm, I don't see how that changes after this patch.
> > 
> >> Where as with this patch, it would not get a chance to be removed from the
> >> blocked list because it would have to wait on the rnp lock, which after this
> >> patch would now be held across the setting of exp_mask and exp_tasks?
> > So that's sync_exp_reset_tree(). I'm a bit confused. An unblocking task
> > contend on rnp lock in any case. But after this patch it is still going
> > to remove itself from the blocking task once the rnp lock is released by
> > sync_exp_reset_tree().
> > 
> > What am I missing?
> You are probably not missing anything and I'm the one missing something.
> 
> But I was thinking:
> 
> In in the original code, in __sync_rcu_exp_select_node_cpus() if
> rcu_preempt_has_tasks() returns FALSE because of the finer grained locking, then
> there is a chance for the GP to conclude sooner,

Why do you think it's finer grained locking?
 
> On the other hand, after the patch because the unblocking task had to wait (on
> the lock) to remove itself from the blocked task list, the GP may conclude later
> than usual. This is just an intuitive guess.
> 
> Because this is an expedited GP, my intuition is to unblock + reader unlock and
> get out of the way ASAP than hoping that it will get access to the lock before
> any IPIs go out or quiescent state reports/checks happen which are required to
> conclude the GP
> 
> Its just a theory and you're right, if it acquires the lock soon enough and gets
> out of the way, then it doesn't matter either way.

I think I understand where the confusion is. A task that is preempted within an
RCU read side section _always_ adds itself to the rnp's list of blocked tasks
(&rnp->blkd_tasks). The only thing that changes with expedited GPs is that
rnp->exp_tasks may or may not be updated on the way. But rnp->exp_tasks is only
a pointer to an arbitrary element within the rnp->blkd_tasks list.

This means that an unblocking task must always delete itself from
rnp->blkd_tasks, and possibly update rnp->exp_tasks along the way.

Both the add and the delete happen with rnp locked.

Therefore a task unblocking before __sync_rcu_exp_select_node_cpus()
can make __sync_rcu_exp_select_node_cpus() contend on rnp locking.

But this patch doesn't change the behaviour in this regard.

Thanks.


> 
> Thanks!
> 
>  - Joel
> 
> 
> 
