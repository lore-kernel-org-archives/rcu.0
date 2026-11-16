Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794788160;
	b=pbDWcn7xw6kYFjweOB4N4+UCw/3G8ryy8gLgLEwxdqkl0RiiwqIl5tSt2JanqF4FqT/J
	 IBeuIoLe3vnl1eU6vx/a0XoXgCHS1LMKl1hjQOZmA9VekKD2Nf2PC1UIJ7VpwEhmnyuKn
	 +EmwHpEXcWVu1E/emc52CUCE3jb99199z9bMart3nTIAehphucpjukqjaJ8VwxXizn/j9
	 2peKB3H8MaV25ePQEJjNxIiDGDxAbUVu8WqBdJ4mM+Tg7lIVj4AEDX8K1enYJWcINamLS
	 o/Txjwbz/zCeg6N9mdyUvJaI4v9rW0ETXjZZopiFbzfGTfB5n9hF4bFgUwLWF0nvy0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794788160;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XbflNfoz1rdC4d5kBQ1bUVRq6zWboFqnaVnEoOvRsHY=;
	b=amI1oKrRCCMxv5mIcVACD/9i8qX1LlkKwUYsN7lMjd3I26HJcFCRQQFGQoEgn3TiD1X1
	 klSNJvbARM+8Ce3hVLCzwnemc6xxhL4uVHIjIATcW5tm7DqQkdV2DMj9jV7D1K5lGaMJk
	 nxtok7jHmaT907iNrucna0pW85g2GQROGIvZsxkkzGdZz79Qj2DxHfUxwVLFPV1sw8N1v
	 SYFXjuIREgBX5/2S9j39PQyK32OFyTjCKPdtZ2pRyy5Nyfs9nF7lTFZBTgG614g1L9Wx8
	 I60wTL/xGVL9apPTbpcY+3QQcUyFOmOAvck5XgPcEH9QbcRpX0pvMXEzYGm4eyIldkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bp9HFEmm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 02125606A31F;
	Mon, 16 Nov 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bp9HFEmm
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7048A1F000C4;
	Mon, 16 Nov 2026 00:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794788159;
	bh=XbflNfoz1rdC4d5kBQ1bUVRq6zWboFqnaVnEoOvRsHY=;
	h=From:To:Cc:Subject:Date;
	b=bp9HFEmmGyo4Y8XZCQON32KppS8KTJN7EbqjHg62h3Dxb4YkUNhXf1ifdNX7xh4eG
	 JyMNWvkGk/WXeSDEnDBh92QyQrf/pf4Ep13S/tYO2ywZerWeDR58214Mw7RFFvHHFK
	 C+q6/DBe5ytIIy1V7SFNz0EB3u9VJeB2DS3D4T3p+a9dBvOaRsQPb9U9IbBJiqwZBf
	 Y9m5QigtLyp9fZAYEHnHLYMSgcjXSdR0b6pn/zXLEz4dd3yJFGhoVtLuq1Oe/j5C+/
	 2xXzvL6mrC62neXa1GxqiC0BgJL9ia/L5vaGb2GbJ1ueOVsGZukMJNBbovl0YFRbMs
	 l5/8okG3elj0w==
From: Joel Fernandes <jfern@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Song Liu <song@kernel.org>,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [GIT PULL] RCU fixes for v7.4
Date: Sun, 15 Nov 2026 19:15:56 -0500
Message-ID: <20261116001556.763913-1-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull these RCU fixes into v7.4.

The following changes since commit aebb7274476403040d582c61478df8f4a7bf9cd3:

  Linux 7.4-rc3 (2026-11-15 14:30:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git tags/rcu-fixes.v7.4-20261115a

for you to fetch changes up to c3f98ff6309a29979e1867bc3c9d4172755ca122:

  rcu/nocb: Avoid unsequenced accesses to jiffies in show_rcu_nocb_state() (2026-11-15 18:52:04 -0500)

----------------------------------------------------------------
RCU fixes for v7.4

Fix a build break with recent clang, which warns about unsequenced
accesses to the volatile jiffies variable in show_rcu_nocb_state() and
fails the build with CONFIG_WERROR=y / W=e.  Read jiffies once into a
local variable instead.

Also replace the rcupdate.rcu_task_collapse_debug module parameter, added
in the v7.4 merge window, with pr_debug() for the RCU Tasks callback
contend/collapse messages.  The messages stay off by default and can be
enabled with dynamic debug, and no official kernel carries the extra
parameter.
-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEcoCIrlGe4gjE06JJqA4nf2o45hAFAmr6RvAACgkQqA4nf2o4
5hCnfg/8DqHU2c4j5ZLgYK7oD99BNg4VTErwkBwwx8eCRb87agrdljsQo8keZBwB
BSbN+gaasl3NvqKUh7lAopAvoZtfk3ymtw4oafDCHa5jJFZV1E2bGUbDBKBwuzlj
6BBHEPFitd5q6z6nlyhSx7289NYoRhr9InMNv/L2kYKnn4bq79Ojf1Z5nQZRHPRz
TUGIwDoVf0G+oh0z2TtrMSNAC4OBPP7Hsq2/m3xaeS2pWS8YziFM7rXcnJaWve4t
D4VjZGWOTQCWOCeYBbyckXSa2zLBSlwCfarbkPfpo1FhdcwBmXdeNvt9MnZ2sRP0
Ff/x+rd5LkzQ3niHYufuxflGv5XLoiaJgiU9rztlD9U2O9sheVaRcf7BaDs77C+f
NmteR2H67svHfK93bOgTNvFVBX90Y4Qa4WPft6g9QbuGkIGD6hJRBbveTeCNsbPM
vmvU/cPYwjcpGZiyPcglpAoIYK8e9F7hspXrpvJTjnoF0p1b2TefpHZS+ozZIcj8
6uD28K2dp+CLAzuLkC5FzgITvWPdIEYiEq9WD0A/kOPO5fZ0+BmOiekb4iBnnHdK
H6HujCvGYhwLGqlJ1aoc7VxoQp+zz9ZOwJzQ4pV9xO/WiHZroEiQvinsgs1+NYOb
jATSr9YPap8CNRqjwMNXK1ppKKkfPdix+JYcx4/WGFzZhCiDM54=
=tbXB
-----END PGP SIGNATURE-----

thanks,

Joel Fernandes

----------------------------------------------------------------
Nathan Chancellor (1):
      rcu/nocb: Avoid unsequenced accesses to jiffies in show_rcu_nocb_state()

Song Liu (1):
      rcu-tasks: Use pr_debug() for callback contend/collapse messages

 Documentation/admin-guide/kernel-parameters.txt |  7 -------
 kernel/rcu/tasks.h                              | 15 +++------------
 kernel/rcu/tree_nocb.h                          |  6 ++++--
 3 files changed, 7 insertions(+), 21 deletions(-)
