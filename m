Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093FB22A7E6
	for <rcu@vger.kernel.org>; Fri, 14 Nov 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133085; cv=none; b=b2ZzBikzfiQI3bA7dYcg8eOOMhAgMUw8wKcsjavN4mLP2jcgShIOFkGtosWN//YKtM3G//IeRac5HIjwsw7er4Cl6gSb/5vr2WpPsYEK9PYhHd5ypakxMfhIru5A8WSAwq91+PR2sDQSa/dRv1IiM5yFTImPE7gIGL5fTXo0Mp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133085; c=relaxed/simple;
	bh=DjmflE6ccSmR8hXooCtO/38G4Xihytqv9kmTm6nuKB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLfLM6qtUVE3IBw2TkJNjRsq+WPkwGdQZ5+lhUAS0Kpke6pg3sd9EXvXs471oGdK47kTgM0Dc11LKSuEIF0hEf+hRdX4SkzLjWUqlRS5ARnvRrDFk7haiNn0Kvy8ywBtYY2YAmxF1TdbrZGmYdBQJFZhFjOKtRN6sIopSJb4bl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VIHU9Zde; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VIHU9Zde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763133083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z88cIt4bkuwH7lP1X8YYrnTJPptFDIGXgV9h1p1EOM=;
	b=VIHU9ZdeHO9V+vVe1KRi4oRxi87q/2wOIEiI4rh74FSuEpg9zVmiaPzlO3ypaF63NoWD4+
	MnjJDwLoC6ffZnVhUc56os2Ms00qshUTy5EA0N6GloftUc93dKDlwc+kP8BSjGpQ0KdhWX
	BLGEx0ZkIEloLhHr2xvMDtd8J5SGczo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-rdbQPBGSMPqDX7mD8R_GZA-1; Fri,
 14 Nov 2025 10:11:20 -0500
X-MC-Unique: rdbQPBGSMPqDX7mD8R_GZA-1
X-Mimecast-MFC-AGG-ID: rdbQPBGSMPqDX7mD8R_GZA_1763133073
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15A5718AB40A;
	Fri, 14 Nov 2025 15:11:13 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.226.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F2CBF300018D;
	Fri, 14 Nov 2025 15:10:57 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rcu@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mel Gorman <mgorman@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Han Shen <shenhan@google.com>,
	Rik van Riel <riel@surriel.com>,
	Jann Horn <jannh@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: [PATCH v7 19/31] sched/clock, x86: Mark __sched_clock_stable key as allowed in .noinstr
Date: Fri, 14 Nov 2025 16:10:46 +0100
Message-ID: <20251114151048.1061644-1-vschneid@redhat.com>
In-Reply-To: <20251114150133.1056710-1-vschneid@redhat.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Later commits will cause objtool to warn about static keys being used in
.noinstr sections in order to safely defer instruction patching IPIs
targeted at NOHZ_FULL CPUs.

__sched_clock_stable is used in .noinstr code, and can be modified at
runtime (e.g. time_cpufreq_notifier()). Suppressing the text_poke_sync()
IPI has little benefits for this key, as NOHZ_FULL is incompatible with an
unstable TSC anyway.

Mark it to let objtool know not to warn about it.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/clock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index c1a028e99d2cd..5ee27349a4811 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -78,8 +78,11 @@ static DEFINE_STATIC_KEY_FALSE_RO(sched_clock_running);
  *
  * Similarly we start with __sched_clock_stable_early, thereby assuming we
  * will become stable, such that there's only a single 1 -> 0 transition.
+ *
+ * NOINSTR: an unstable TLC is incompatible with NOHZ_FULL, thus the text
+ * patching IPI would be the least of our concerns.
  */
-static DEFINE_STATIC_KEY_FALSE(__sched_clock_stable);
+static DEFINE_STATIC_KEY_FALSE_NOINSTR(__sched_clock_stable);
 static int __sched_clock_stable_early = 1;
 
 /*
-- 
2.51.0

