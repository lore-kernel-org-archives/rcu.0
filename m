Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECC28DF21;
	Wed,  9 Jul 2025 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057750; cv=none; b=UJhJZlKIoXPLX2A/rL0Znm7ct0xHqrivYrLrmtpvL5EOxJW60qRM5q66IGj4PbFvUoluAgUTx26oDRwOR4BPHB3z6QStoD/VzedR5smWYsuOyCdbd/rbIFI2vhB29gQ6Yk719RvzABTAgUCDINLi2SmXTZQJPh6l+5MQOtgv3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057750; c=relaxed/simple;
	bh=+H297YmHJhuscrEy/nqGHZDT2K/aMGUWwUqven0pAeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R/dtUE2XaLoNVWx3o6QBCzptmPDLP8p8e6NoPB5ZGS9iWNIkQ5IwolAty25j0DWYuQ9mCjPA4TPnX2UHJUS54UsV6nvCUxGHv6+nuC+IOOWiSSDo9gkjvFOj5jfuOQvSpgi4Ps+69hppG5531CC6+S6YzxybezYSpTq6fvWhoFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvGRd7wa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvGRd7wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD02C4CEF4;
	Wed,  9 Jul 2025 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057750;
	bh=+H297YmHJhuscrEy/nqGHZDT2K/aMGUWwUqven0pAeY=;
	h=From:To:Cc:Subject:Date:From;
	b=SvGRd7waKUMRfO0xLsWsPWw2y4r8I1fR9scMsXXt3pXO0XUVt4hXvdMRk7fzJnKAo
	 1ZJHJY6OIFdkhHcduORWCH04spC3+6hzSZ3BaaRowomfZ7l/19eYrcbvJ88yi8Qz6Z
	 KcAfsom84Py4XmWtIZBdaWQlADWl4alDynLmsQULLUvFcO540kCAOts7ANBKVCbFhz
	 0Zp1vQgb15M47Oz+/kk80n+ivUxoH0GfMeghjgl9NDwDCqJJZfdH4+pjVSVFAsiHcS
	 L0+dMshRwE0fBbRm91AtTlxIlNQKe5PysNe8BYubA5gAOGSNIlVI+oceaXewjvdMR3
	 S3nIfpUvRJQhQ==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 00/15] RCU torture changes for v6.17
Date: Wed,  9 Jul 2025 16:12:00 +0530
Message-Id: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>

Hello,

This patch series contains following updates to the RCU torture code
(rebased on v6.16-rc3):

Paul E. McKenney (14):
  rcutorture: Print only one rtort_pipe_count splat
  rcutorture: Start rcu_torture_writer() after rcu_torture_reader()
  rcutorture: Make rcutorture_one_extend_check() account for hard IRQs
  rcutorture: Add tests for SRCU up/down reader primitives
  rcutorture: Pull rcu_torture_updown() loop body into new function
  rcutorture: Complain if an ->up_read() is delayed more than 10 seconds
  rcutorture: Check for ->up_read() without matching ->down_read()
  rcutorture: Check for no up/down readers at task level
  rcutorture: Print number of RCU up/down readers and migrations
  rcutorture: Drop redundant "insoftirq" parameters
  rcutorture: Make Trivial RCU ignore onoff_interval and
    shuffle_interval
  rcutorture: Make BUSTED scenario check and log readers
  rcutorture: Remove SRCU-lite scenarios
  rcutorture: Remove support for SRCU-lite

Zqiang (1):
  rcutorture: Fix rcutorture_one_extend_check() splat in RT kernels

 include/linux/srcu.h                          |   2 +-
 kernel/rcu/rcutorture.c                       | 356 +++++++++++++++---
 .../selftests/rcutorture/configs/rcu/BUSTED   |   3 +
 .../selftests/rcutorture/configs/rcu/CFLIST   |   1 -
 .../selftests/rcutorture/configs/rcu/SRCU-L   |  10 -
 .../rcutorture/configs/rcu/SRCU-L.boot        |   3 -
 6 files changed, 302 insertions(+), 73 deletions(-)
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot

-- 
2.40.1

