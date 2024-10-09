Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC361A76D5;
	Wed,  9 Oct 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496826; cv=none; b=gdj6HEtpKmMINxp3u5ChQxqb5MMho18fP7c3JW4O5X13O1hTgbUZ47y/BLIg3C/lc96YHs3enY9uHCx9fudI1i0T8Zj+XDxUG/stf+/0DKnzHBIavUsK20TamH7xPYnXEkbn/HBA7GLvujJR/NnSisjjn3vdw8nkKhUKUTmp14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496826; c=relaxed/simple;
	bh=ULylfd/orvzxXyLN6k+OZ5VccOQzKRlCRQmp4wMqnwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TIVOZjJoBJMukZmhimM/Z9XGVfis/AbE2X2/r0EJg/ituzxVGEAYMKNtndbjfpB9su2jtfA/28wNbFpk0Fpfk4he0nc6vgl+8ejEQOgcaidDOW0Si/Q72NJhm20WBtPA4ja1HOIcHsqcF9siA4royY6/YqSKPOZ+Ii+HpYKNEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1VHbvw0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1VHbvw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB58C4CEC3;
	Wed,  9 Oct 2024 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496826;
	bh=ULylfd/orvzxXyLN6k+OZ5VccOQzKRlCRQmp4wMqnwQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=S1VHbvw0A/OwJ6NuvVm3cd48Kkkr+KOuGn85XT2EINo+X13ii1Sh6XXFAHZbUSTQV
	 TCli8rr++xocgaqf0rcACJTcvqrbL6TZ5HTjduNMdRcfoFx3oxEVPKxfpAHztD8+7j
	 NiqUYiJv5u+Hw7Rx/wD6J1wRoqkJQtUCWapDK8kVlyhZ/ofz876z7JeOlkshDGdLlI
	 2hQaLvIg9p0jHssWZmmmDLn9C3uDhAKUD+HgadKHVOO42tecOBCKKhEdNE3VJzXffp
	 Y6J2pL4o8rVN6JwxlxcO2S2tDkA50/bh6st1U+DiNsf8ZpMOLO6X/IxfFKlgSmu+G4
	 W1FTdbbruB7qA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3536ACE08E5; Wed,  9 Oct 2024 11:00:26 -0700 (PDT)
Date: Wed, 9 Oct 2024 11:00:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH rcu 0/7] Miscellaneous changes for v6.13
Message-ID: <2dc6de07-374d-44da-82e9-fa9d9c516b46@paulmck-laptop>
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

This series contains miscelleous updates for v6.13:

1.	Add rcuog kthreads to RCU_NOCB_CPU help text.

2.	Add rcuog kthreads to kernel-per-CPU-kthreads.rst.

3.	Allow short-circuiting of synchronize_rcu_tasks_rude().

4.	Permit start_poll_synchronize_rcu*() with interrupts disabled.

5.	Test start-poll primitives with interrupts disabled.

6.	Remove kernel-parameters.txt entry for rcutorture.read_exit.

7.	Remove open-coded one-byte cmpxchg() emulation.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/admin-guide/kernel-parameters.txt       |    5 --
 b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst |    2 -
 b/kernel/rcu/Kconfig                                    |   28 ++++++++++------
 b/kernel/rcu/rcutorture.c                               |   10 +++++
 b/kernel/rcu/tasks.h                                    |    3 +
 b/kernel/rcu/tree.c                                     |    7 ----
 kernel/rcu/tasks.h                                      |   17 ---------
 7 files changed, 32 insertions(+), 40 deletions(-)
