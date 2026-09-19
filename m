Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6D1FDA61;
	Sat, 19 Sep 2026 00:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776065; cv=none; b=GQPIU5eVRUaG9i3QGmlVMf5BZRnoAT9JGeGTHigbfSqgteL41pOEU2BztdtE4DPytRSByb+kmZrA55LLaVWr9zvGW36d8RMOaX2BBYb4uJLuw84yUVNte3z5PSX75jCXzgR+xMzKQY1T7z6GM8KEDcKE30hn3vs+VS83g1jLJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776065; c=relaxed/simple;
	bh=Fq5AqRRDy42/hmTYb6ZLLIO/xfW4bnigoGWDNd5bxwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ur8CMephM4h2WmEWweASuPlhhQ2LwHmiYH0wiMs7EB3gCqIFExqxdV0tvqwj2gq/f394zmneq/SYXKOBgQSluBD//O+AuVCnbRc9sSAWLx+rXVshTnJudwI80eZs+7vos0xU8Ps/hCAitWymmgHGeKl9ahaRcWFxokKd3G8Nl8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTjN4p7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTjN4p7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682B41F00921;
	Sat, 19 Sep 2026 00:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776060;
	bh=ABWwqarNcME99tl7+exnfFfe/8JsXmT1yEbSCPGP5q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTjN4p7rqHFNzxCoYm0LwoXSGrTnMD/er85otdny17J39wUnmnqpXV7qQB24Db8Zy
	 LfmXsxK+GplEpJVFUTJt0grSt4BNXuIULFN4xVLdvqEamIX5J4Uh0BnulKbhhsOEsI
	 XOUziftwP9YLjwMnGePRJhQyELaRphm5HayYpra/GOva78EANy5iOyClYRgalAPM9a
	 jnGaTsukewcso/DG6G6HlGL5/b5jN/OfEu9SKdMkUeHrUIMa0/ao9X7IMkLq3QyhMq
	 luyoBKCVhrrLb3IsuTz5JL95rY9Y/lzSl8w0Z/jBCqdRNVYmkBJbw5cn++4MSs1tiD
	 DnE3p2vRF+4Nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C961CE0F1C; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 23/28] hazptrtorture: Enable CONFIG_HAZPTR_DEBUG
Date: Fri, 18 Sep 2026 17:00:51 -0700
Message-Id: <20260919000056.3132131-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit enables the CONFIG_HAZPTR_DEBUG Kconfig option in order to
more easily debug hazard-pointer handoff issues.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT | 2 ++
 tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT
index e2da430abe4d..405941f3b50f 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/NOPREEMPT
@@ -15,3 +15,5 @@ CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
 CONFIG_KPROBES=n
 CONFIG_FTRACE=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT b/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT
index b8ea4364b20b..c5b12f3bef74 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/PREEMPT
@@ -12,3 +12,5 @@ CONFIG_HIBERNATION=n
 CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_PROVE_LOCKING=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
-- 
2.40.1

