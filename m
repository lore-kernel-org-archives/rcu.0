Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A872080F4;
	Mon,  3 Feb 2025 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595137; cv=none; b=T3qA1H5tX0+cdDJp8ajccjFpKYuRjB5AavjcWMD0DCJMClbtz7DOuqDPk9hDjnD/MJmuQgo4Fai+tIiOplxej1F4g6KWyi586nnn0nbAocXwXdKPuQbEgWaz3CHhX+j+4xGMmBleyfH1EaUicS+kYhMoVgJYlDy/mWYNs4Z+e2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595137; c=relaxed/simple;
	bh=VaKLAjn/l0t1TtuRAmtF3V++jpLsuyC2p9YEB4WLpo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MoCR2/3FmdAFqUuy4o9SHfIECSVQpLljUHcZaqR87WMLYL/O2750K069VMTAqSFcDJzPUVipHZQnMAIInGBQo0AHa/POG1FfzyekxV/NylROANJPkVfFqinftYme+tiJCZGaaWVM4pQp9uS2LszuBoYqHJRGbX0qV6g/u6DJVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CbmBvNNK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1BoS5Tp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CbmBvNNK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1BoS5Tp"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738595131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ezv6qb5cNNsaMcEtZ7r3pKbzCCpir//ethjTburXnTo=;
	b=CbmBvNNKT2K6iAoMLXzAuYb7vC7U36RxhhHJvGBlLs8bB9TgyFwqkcZ1IIizbfo4/OGRCT
	mly4kr6pHUmSkcGBGFrl9kRQZIDccilkpLigq0GLDJkQgSSPRt4l8sOShAlxGFQqRInAx2
	vyBDJ4xAcSDzfVsFDQMw9HNy6kokpVs+M8THlfarLeEneY9XVrmwl8EY9PYg4NzPQVvTdY
	WlXn1HKH5LUGvgntq0GorfXAPWTN05KXSNRN5XeebQNEfh06UlZBWgD89WIar9N5tIhtjo
	c2E9uzw/9j7ghZyzPSaVLokZNxIoxRCqQT3RcePOKXqEfjDIDHuFG6LNr+10rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738595131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ezv6qb5cNNsaMcEtZ7r3pKbzCCpir//ethjTburXnTo=;
	b=O1BoS5Tp1YPjC0scDBmWbuUAt2LD9ePlJT0+PTmAGq3TmKQcVbev+pibrZuIqzFdqWeOmx
	clu27sFfcpaCSQDQ==
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	MengEn Sun <mengensun@tencent.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	YueHong Wu <yuehongwu@tencent.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 0/4] ucount: Simplify refcounting with rcuref_t.
Date: Mon,  3 Feb 2025 16:05:21 +0100
Message-ID: <20250203150525.456525-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I noticed that the atomic_dec_and_lock_irqsave() in put_ucounts() loops
sometimes even during boot. Something like 2-3 iterations but still.
This series replaces the refcounting with rcuref_t and adds a RCU
lookup.
This allows a lockless lookup in alloc_ucounts() if the entry is
available and a cmpxchg()less put of the item.

Patch #1 adds HLIST_NULLS_HEAD_INIT for which I added the RCU folks.

Sebastian

Sebastian Andrzej Siewior (4):
  rcu: Provide a static initializer for hlist_nulls_head.
  ucount: Replace get_ucounts_or_wrap() with atomic_inc_not_zero().
  ucount: Use RCU for ucounts lookups.
  ucount: Use rcuref_t for reference counting.

 include/linux/list_nulls.h     |  1 +
 include/linux/user_namespace.h | 15 ++++--
 kernel/ucount.c                | 97 +++++++++++++++-------------------
 3 files changed, 55 insertions(+), 58 deletions(-)

--=20
2.47.2

