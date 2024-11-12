Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ADF2309A3;
	Tue, 12 Nov 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423126; cv=none; b=agbB3GkMutsXMcFmKesl4cZ6PtVdtNGaPEJPEbkT7S4F8ENqebglxC35FgmuvwzWt7XfoO0QhaslX/T9XFVBvNvykDv5+qovyGvYkxW5IpCOYV8VJexwWGYf9OiMPC4FsXzt3s8/JbbgflnttgocwKwFMmphXmPLZFH9dIuTyA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423126; c=relaxed/simple;
	bh=b7Xt7FMDlXDgljySpoqqAYI+yQJBj2AoyiAgZzXZNc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=quQZl1OiMZe0hz7b0NXFZlDwNZgVpp7k21TTNoDJuKGvC6PKa7s8ElE/sX5SXBlAIde+kWqM6jQi4aG135Y0Q2xgHpu0Vt9qIuuZvHEqNIc30DuZDszKmUB2RBAmCv2ZFR6uGLMkZOM8aUY1MdMeYRenqdRk1YNKqwbyffX0yck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6S3PDsd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6S3PDsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE21C4CED0;
	Tue, 12 Nov 2024 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423126;
	bh=b7Xt7FMDlXDgljySpoqqAYI+yQJBj2AoyiAgZzXZNc0=;
	h=From:To:Cc:Subject:Date:From;
	b=D6S3PDsd3/EvpOycxRcxQpm4xwoy0Wng00iwUhjY9I8JvPAgH4LbWRCi4OV30lgBF
	 EZh7eJaSHg0ybyvS2Ma+h8G31EY4T5Gf7JMZAyl8RzaPnBNdO4zGkxbpcz5LW61lLd
	 MTb4fpAkMEttbHKHiMlzBJc4DO9shrbvp5TnM9ZVFfJeh0BIj+PzfJFGeqEUReIeAn
	 uqKPL7d2cH1hPlu3a4IMmNAYkoA+e2DvdUB1XI/fCLfhreTUME1yhm/+gRfT3hJWlx
	 aYAQhqAl3JhKDxjtABiD7VxfpKjm89MXjGeOhPqWav8s044ebflRDKPbNgMOlptqVd
	 Hj4V+B0Xs9IQw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 00/16] SRCU for v6.13
Date: Tue, 12 Nov 2024 15:51:43 +0100
Message-ID: <20241112145159.23032-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Please find below the SRCU patches targeted for the upcoming
merge window.

Paul E. McKenney (15):
  srcu: Rename srcu_might_be_idle() to srcu_should_expedite()
  srcu: Introduce srcu_gp_is_expedited() helper function
  srcu: Renaming in preparation for additional reader flavor
  srcu: Bit manipulation changes for additional reader flavor
  srcu: Standardize srcu_data pointers to "sdp" and similar
  srcu: Improve srcu_read_lock{,_nmisafe}() comments
  srcu: Create CPP macros for normal and NMI-safe SRCU readers
  srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
  srcu: Allow inlining of __srcu_read_{,un}lock_lite()
  rcutorture: Expand RCUTORTURE_RDR_MASK_[12] to eight bits
  rcutorture: Add reader_flavor parameter for SRCU readers
  rcutorture: Add srcu_read_lock_lite() support to
    rcutorture.reader_flavor
  rcutorture: Add light-weight SRCU scenario
  refscale: Add srcu_read_lock_lite() support using "srcu-lite"
  srcu: Improve srcu_read_lock_lite() kernel-doc comment

Zhen Lei (1):
  srcu: Replace WARN_ON_ONCE() with BUILD_BUG_ON() if possible

 .../admin-guide/kernel-parameters.txt         |   8 ++
 include/linux/srcu.h                          |  90 ++++++++++---
 include/linux/srcutree.h                      |  46 ++++++-
 kernel/rcu/rcutorture.c                       |  65 +++++----
 kernel/rcu/refscale.c                         |  37 +++++-
 kernel/rcu/srcutree.c                         | 123 +++++++++++-------
 .../selftests/rcutorture/configs/rcu/CFLIST   |   1 +
 .../selftests/rcutorture/configs/rcu/SRCU-L   |  10 ++
 .../rcutorture/configs/rcu/SRCU-L.boot        |   3 +
 .../rcutorture/configs/rcu/SRCU-N.boot        |   1 +
 .../selftests/rcutorture/configs/rcu/TREE10   |   2 +-
 11 files changed, 295 insertions(+), 91 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCU-L.boot

Thanks.
-- 
2.46.0

