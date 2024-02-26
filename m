Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0414112CD8E;
	Mon, 26 Feb 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966829; cv=none; b=DoGWO5vZPd9XfSDvFDcswfp7CQDatPchvOT0hbqgubNlprvdGATqDQjYEmSeLGq6a2ZEXKf6SLu9kJoVMw8N7/CY2yZtkzPPqPF+emD4brAYF4ttsMHM55A/ApvR3l7wAMfMQiLhF1502A+qgRqtHImJ9L2UmK36ZCZ9LJe1Jjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966829; c=relaxed/simple;
	bh=sxy+LatajuR8Cqdw6yJ8oXQH6SsVfQp6uEG50xmQ4AE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U+8UVvx9KAFI4vKqo3kcCRZ8agraCllT3eoRCNRTezd0+IyQqEO/DtKbIEzspAixS7LvX1ncLdzOkMZtqO9yFRrbAtHL4omJETKCkpNYCA+w+35n5fp+vLybX2IAjgOO4ZprXiWLBG5zhkKsvk2bwMOdVpflMuyII30/fcVCAbA=
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
Subject: [PATCH 5.10 0/1] rcutorture: Add missing return and use __func__ in warning
Date: Mon, 26 Feb 2024 20:00:10 +0300
Message-ID: <20240226170011.22798-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-01.aladdin.ru (192.168.1.101) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

Svacer reports a potential division by zero at rcu_torture_writer() in
5.10 stable release. The problem has been fixed by the following patch
that can be cleanly applied to 5.10 branches.
