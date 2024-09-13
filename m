Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974C1E884;
	Fri, 13 Sep 2024 21:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263739; cv=none; b=aRw0X2k4kL6lO+tbvZK8k2VY7zaLbCknxHmfIIkXlLQl6u27XS/xYguQKicTNOrdL14NWNm+aIWa5Jc+s6dslEKEF4aDohQV22NTQg+QNvoenDPe1HR4wu90NKJHPDgSTQpJkE6skHMXRrchBdWwqKhrebN0hIh+QOtiKGph9hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263739; c=relaxed/simple;
	bh=0zPnoLWCkUohohwETprXTWLzJsDno+a5kFJcw1Eqsd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ewogw487W5dyFDmEKX4KRmnZL0bl66EAjkRD19yc75bjf57YMPOakw490hhUlev4Rrs3WmcwDk2za3uA3LMXStmOjyAS+3Fg6KG5JokO6Dz5rfOZ3wUbJDJMoksW6J0ZRY+IsHz7+/evkKfRRfch9UfmnHYAjpuB6VVb9ZSnkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtEINIvv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtEINIvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C06AC4CEC0;
	Fri, 13 Sep 2024 21:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726263738;
	bh=0zPnoLWCkUohohwETprXTWLzJsDno+a5kFJcw1Eqsd0=;
	h=From:To:Cc:Subject:Date:From;
	b=KtEINIvvd20MC5ixz7RghmHso/DiVZAxjhoegPNMIPEmvi/8OQ//Hr3N3r2yW31+U
	 C9m2VZ39A13iEAFRSk5YzBIEm2v6B2/mBLOW0oKcVeFAsYZfNOEgK/rdL+ffDtbhOf
	 GNUkBov2ymPl9toLxQT+2ZtwLX6CtjAb86ShBRF2UQzvjnapE4ksE8vLZKdUTVvYhY
	 IY1HIJTZC9uubggzXhubcbGRAZ30MjQAaO6A7EKYZvHbllHQtdpT51t2uWTaNUgmZ/
	 IO5nK5/NXZP9HRlhLjMYLjOf7+6MHhvN24H8cUdtXmFA6r7zuTdOZGqRlLMnQ7hDrS
	 qzl9ZzzWqiY2w==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>,
	Cheng-Jui Wang <Cheng-Jui.Wang@mediatek.com>
Subject: [PATCH 0/3] rcu/nocb updates
Date: Fri, 13 Sep 2024 23:42:02 +0200
Message-ID: <20240913214205.12359-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series include:

* Fix another RT wake up while CPU is offline (reported by Cheng-Jui Wang)
* Cleanup rcuo wakeup
* Remove another superfluous barrier

Thanks.

Frederic Weisbecker (3):
  rcu/nocb: Fix RT throttling hrtimer armed from offline CPU
  rcu/nocb: Conditionally wake up rcuo if not already waiting on GP
  rcu/nocb: Remove superfluous memory barrier after bypass enqueue

 kernel/rcu/tree_nocb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2

