Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF96DDA6;
	Fri,  2 Aug 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559383; cv=none; b=XvTaFsGaNjM4fKjfXA5o81J1gDY5jawhfQMgQNjL6QDfC1zP2p4P8bf1BIsBEpvOxYZEBSBp6AweD8cWdvaZ2IV4Esx6k1+HskeQc67JfaFPC6zyKV0qrrvnZaoq37vJf5ZXqDWgoCTmTbdZuY783ddXaiHbjAm5gQyci2dAy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559383; c=relaxed/simple;
	bh=Y2xKpunutoEymmvEXzw0uAInIt9lBUEGZEmwoE4dEao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bVQfMihe49qRxc/7dGuG7oEIBpRt6uFMLJxHQeKQqF3W/NaQdl910VmGSax15jRZaAcRR7jaIRipbRkbywKt1vNhXwacWL1efvKERi4TtFhP2o6n76kTgRwj7SunJfa00G/CWF9pJGw3zGTAXqLUTxOioDBzd6ZZFP14XXqW1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuDgAh2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuDgAh2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F64C32786;
	Fri,  2 Aug 2024 00:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559382;
	bh=Y2xKpunutoEymmvEXzw0uAInIt9lBUEGZEmwoE4dEao=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=OuDgAh2DezByaLp/S2ZrUhGzdCv27qMf+lMMd6MQ9wqrEYs72xIgyYuBR4KLpmOu9
	 RDgtuDaCf59rqupq0ciO5HdSmkR9b9yAZ+FNO+Y2ngGSQDIUAt1GNB9uPitev1FGMK
	 joD3o0GS+6IJex5fTAV/BYVVe7wWir6IDAjTUCM8Xg6XGH+fI6kNu/NECZqy8jVVjn
	 6AKKVP199wVIvRvhQQK1sU3C/CazAzbQ5JTIy8rMaVQlTnpvmEXB5CXT7rrWIgFihq
	 IsxX0hZkR287IJj1Czi18ePkQanIZSNuGhfxxbUzRUM5N71fZ66Wf+6Lkhanqtkqcj
	 k8REtpmfiSt+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 29D80CE09F8; Thu,  1 Aug 2024 17:43:02 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:43:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/11] RCU update-side scalability update test
Message-ID: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series contains updates to RCU's "rcuscale" update-side performance
and scalability test, including a fix of an brown-paper-bag bug:

1.	Save a few lines with whitespace-only change.

2.	Dump stacks of stalled rcu_scale_writer() instances.

3.	Dump grace-period statistics when rcu_scale_writer() stalls.

4.	Mark callbacks not currently participating in barrier operation.

5.	Print detailed grace-period and barrier diagnostics.

6.	Provide clear error when async specified without primitives.

7.	Make all writer tasks report upon hang.

8.	Make rcu_scale_writer() tolerate repeated GFP_KERNEL failure.

9.	Use special allocator for rcu_scale_writer().

10.	NULL out top-level pointers to heap memory.

11.	Count outstanding callbacks per-task rather than per-CPU.

						Thanx, Paul

------------------------------------------------------------------------

 b/kernel/rcu/rcuscale.c |   10 --
 b/kernel/rcu/tree.c     |    3 
 kernel/rcu/rcuscale.c   |  206 +++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 191 insertions(+), 28 deletions(-)
