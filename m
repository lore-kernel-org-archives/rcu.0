Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62A56458;
	Tue, 27 Feb 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029594; cv=none; b=GedweusHHmPite1Y0GbB7j3kyBlUc8efXOnck0nYhfMzxyjOIhe7t1OShIQBy0fNrORuoShqF7Ata52vNmIZYocPrpERYj0F7oTYGQWyQMLfbEUaAT70HNWMBwDS7D1n2E0bymuIK2SB6C6enX1FqvTrZ2R2k79VDG5hk885X38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029594; c=relaxed/simple;
	bh=uBst/JSkf++NKBU28kH/if5DVBerMc9sdPeKjb+6HIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bBsckRiX+IVyUmsPaU3tPAJ91qRxlXtFLwjcSbGn6H2ITJ53ofKIMsYcw9eJR7ikbK0n7vh8ftsmPMH2HU7aO+49jPKsNKtQGVPJoeOoOrBhPmScdKC0sJ+gjlk4UbXstFKV2UfYJfM2ZeLnyWC2t9Xc9CC/3OYFN18oo2qjhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett
	<josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	<linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.15 0/1] rcutorture: Add missing return and use __func__ in warning
Date: Tue, 27 Feb 2024 13:22:21 +0300
Message-ID: <20240227102222.29584-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

Svacer reports a potential division by zero at rcu_torture_writer() in
5.15 stable release. The problem has been fixed by the following patch
that can be cleanly applied to 5.15 branch.
