Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031570;
	b=RvbpSZmVvv2A055Ut3SKI3+KzORzvfIr0EdA6NXueHEU6hmiuuH709fbWoWZCAT69nSP
	 vPqSSVtVCcSxahy9nIEcmMO31yzATOj2dEYwOkr1iNei42tx0nTjVXKp6/WQaSxxcZGwc
	 naLvGra8oAb0zBXBIeXNbGqEwH85nqDQKG79vs+pDds8fsp2njrC25X/6xOrYskor/EF0
	 JmmxhjQaniBhpq7iQOi9ked8F25aGCxN5/4kR0N33auGQLvul02c0bsnEux/+xNpxKode
	 AWqQ0Rt4shtv3XLTDj0IcTuCCcQc+80Dym7BM8kyTUxp7mOwLrZO9JQFiZvvFWr0WUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031570;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Bj42jV2UG4MfEqnudGoqeQXk6YWIDh19S1kTb7pWI3E=;
	b=G+wDD7I/Myp5f3DmOq/yBGrPpYCIgQsIzbVbxWMVgzJwokTedZhAd2S4BqWLIqNi1Ngc
	 pVRrwiWH15Duu0xpuJQ2mohfM9iVv/Nm7n9Xn7gjfg/c+jvoi4mQfxLPIUUHX/QZZmak9
	 InjIMba4h6IA+TKQIVaxf4J+//PjEHJ9DvnvBMk7zZ4672or3NFfkZ7Vyoj80X+XP3rG+
	 nY+cOdbsBCl6b6HPOWJjp83O32sKQjY2CultJKlhIBHLiDlVWV35L6I3nXeF8amvovUbk
	 63VSIQHZOwx2JAuJvrLM8mrpl9NY+LGyRQDUqIzVk0RIBUijOEFPmXerpilBIw1prbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJ53jzVI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03B606A320
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NJ53jzVI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14C71F000C4;
	Wed, 18 Nov 2026 19:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795031570;
	bh=Bj42jV2UG4MfEqnudGoqeQXk6YWIDh19S1kTb7pWI3E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NJ53jzVI33vZ/qNPrX5RGhNhKhgO0yOj1ozjVpi8Idsv131FvRdeqFboMz0MXWv5l
	 UWM7eJ3EcfwFxDWqU4qPNHkMO3TBFCQyYIsyAH/SVEu0pRLDixdBtpdsvVI5iOg60v
	 QmEbMwbaGvZ0uNTPN+nXrUW4JH6u60dAeG+CBoNeH73TCw6M3tHcUaZfXsKvO19yIO
	 pFVw1audDa35sZkNlbZcnGlwLcBjsMjCUEn5Ug8Wc9a24SK62de0/ulKy3cTti/XfR
	 Qmn6MCFzB7p/p01FeDen++r2AR5itYmsxmHMrsAA+0TWlIczTS7mBm0++gEXttq6z9
	 JXh3+Nhuy6pWQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 61291CE0FA1; Wed, 18 Nov 2026 11:52:50 -0800 (PST)
Date: Wed, 18 Nov 2026 11:52:50 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rogge Ohta <roggeohta@outlook.com>
Cc: "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [BUG] rcu: Wait-queue list corruption followed by cgroup hangs
 on Ubuntu 7.0.0-43
Message-ID: <dcad17b5-86b8-4394-a28f-d520950af63a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <PH0PR01MB8022450E2462F326C65F5C22B67A2@PH0PR01MB8022.prod.exchangelabs.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR01MB8022450E2462F326C65F5C22B67A2@PH0PR01MB8022.prod.exchangelabs.com>

On Wed, Nov 18, 2026 at 09:34:40AM +0000, Rogge Ohta wrote:
> Hello,
> 
> I observed an RCU wait-queue corruption warning followed by a system hang on Ubuntu 26.04 amd64. The kernel was 7.0.0-43-generic, Ubuntu package version 7.0.0-43.43 based on Linux 7.0.14. The system is a Gigabyte X870 EAGLE WIFI7 with BIOS F13g.
> 
> The first warning was list_del corruption in rcu_preempt, with rcu_gp_fqs_loop() calling finish_swait(). Using the symbol table and BTF from the same kernel build, we resolved the queue-head address to rcu_state.gp_wq.task_list. The waiter’s prev pointer pointed back to the waiter itself. Sixteen subsequent insertion warnings showed that the queue tail still referenced the same stack node.
> 
> A later hung-task trace showed a process blocked in synchronize_rcu() while writing to cgroup.procs. PID 1 and several runc processes were waiting on the same cgroup mutex. New SSH sessions and container health checks timed out while some existing services continued to respond. A reboot restored normal operation.
> 
> This happened once. I do not have a vmcore or a reliable reproducer, and I have not verified it on a mainline kernel. The initial write that corrupted the list remains unknown. Does this signature match a known issue? If it recurs, what additional evidence would be most useful to capture?
> 
> This report was drafted with AI assistance from the recorded logs and kernel source. If it leads to a fix, feel free to credit me as follows.
> 
> Reported-by: roggeohta roggeohta@outlook.com

This is the first such report that I am aware of.  Given such a write
corrupting the list, the RCU problems that you are reporting are expected
behavior.  Was the same address corrupted in both failing runs?  If so,
it might be worthwhile monitoring that location.  It might also be
useful to look for subsequent Linux-kernel commits that fix bugs that
corrupt memory.

							Thanx, Paul
