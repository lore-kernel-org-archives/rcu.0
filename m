Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5F017C9E9;
	Tue, 17 Sep 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583703; cv=none; b=mUnCnKui5mAOD2R/dqJCsUtfF1rB4a+1PTDj7Q3dxQdqpZ0vUFAdNCtG729xkb8TpGFtFEIS2hbA5w/njYf5qAqsaYVG7VMzl+g+cjWgOrX/3a7LNgZVQVGVMgnurJGyBnDEmhpIN65pnRX5fJTl9EVppcnltUgwpc9rEgU02c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583703; c=relaxed/simple;
	bh=UEzTx9D/4aIem3SYwDJSGjr2mKzWLG8B0R4I+L4ZtQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4ws+tLzkRUJ9xcA7B+TxZbIeczYGv+mXiUUDZnqARdYA33Nt5zp02HV7cIuztWyLQGTNw0tH5x/vK6PTTb7Nm3FZmBTsrZAhSPEomEhaC5TP4xwsA55rq3kwPyhG7up/G/xE6bHvWNYDssMDD1Nu0UZ1YokvQ5Gn6omoCmce2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lowJ0vTG; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lowJ0vTG"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c579748bf4so44300066d6.1;
        Tue, 17 Sep 2024 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726583701; x=1727188501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cLQI6kZ6TnjcLlPN0cihMK1F/E38o+9g1wKleRuuDyM=;
        b=lowJ0vTGORomv5QklVJK5iEMh4WwT6cttc3itDOnaXNGxM2YXvsCjPwHGsg3+NZs8A
         2rYOoxDUtfGucLkNA1kdb4OwsSXIJcs+da5nXqhLnH2A2GQp7XB7EqNAt8e0Y4Rhu0XM
         d6vprPfqiBIK77dOflufP2F2pAfbmXm0UYnprU1VEIwlelrB+sNndQUmKsJaMGnTYsLM
         PzIrSBfTDO+scRkWacNrPebC8wUjy8fQUKSSaHwmGQv640NOddN1r87Wfs+RI4heiiv0
         Cej/jKUae4smSeB0QGO8rqMISO/sIklewhipO8l7E7MBLA6VwnrQhiksvUrI+5wc5S96
         T2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726583701; x=1727188501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cLQI6kZ6TnjcLlPN0cihMK1F/E38o+9g1wKleRuuDyM=;
        b=tXRf9eSHXLSRQuBEZKmcA3O+EHB9Vzrl/H9H32JPMswNxZBEKnn/FBMO89DNXj3lBb
         M4VQKz9fKCEKXI8Np0IoUVOYlZMdPC/6tklWN+hXujq4Wa0jNDAuvUqIy3UTKI+xc/c/
         4JwciY4qe4zTT5XdY5e2H9GgTA9sbqMmUjEc0MgvQSQBTdgYsmHjJICPC1LBE1Gv5dKK
         KMBH/x3BKmj1PaaftZqmOMKYqLowuNKdsXAm3r+2jgn70MkfZhI0gWdnp1wf9fShxN9f
         HLbhc3PUiivGCA6Rkzpbc6jmrRVLNuPY3d2WbyiKmC8GW4WImTonHg3THRZg3iCIJedu
         Z4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtzRm1133qO6AXdRAkOZ8xl9qtidTr4Anu8scCpzNHdlDD3INGv6PBDX2drs75d/vPwwDx@vger.kernel.org, AJvYcCXVtPgoKOlLbbSQ+uSF7fsfPLNmp5N6jblJZRmQCnlhZiqX/oiPzwLeXJ2SW95KDsWkscbd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mUmiimeXP+FKdqQp9m9ylynYbN7h/fY/AA3+5UFTDVvvupay
	oMP2PJjWwzGWEM3+eaTUOceQCtsxUD0mri3hEhlWjDpeE/apeOUV
X-Google-Smtp-Source: AGHT+IHxAlrf3264M1eG0sU+WYQOpz1SeCGp6P57WflWDJF78YqG3aNM3gQ3OugWPUyeVTVmITSVWQ==
X-Received: by 2002:a05:6214:440b:b0:6c3:62bc:5de3 with SMTP id 6a1803df08f44-6c57e240938mr223177656d6.53.1726583700929;
        Tue, 17 Sep 2024 07:35:00 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c645d27sm35018466d6.73.2024.09.17.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 07:35:00 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id F227C1200070;
	Tue, 17 Sep 2024 10:34:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 17 Sep 2024 10:34:59 -0400
X-ME-Sender: <xms:k5PpZoyBuEtWz4UGkULBJa6aW9UOXEmvIx5H_9jeFJi8QNvqTvtrpQ>
    <xme:k5PpZsQM-R7W-zPeDB5SqCvKg99YKQRNc0QqEBt6d-I3P0Ri2VbF-DxUdK0cqZe5f
    yeksXmFnHqaqki4_A>
X-ME-Received: <xmr:k5PpZqXfkqX4SPEUwBWiRctbcYiD4nd3B2gGLkqNkqu_un2JmSxJR_nfH2I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveff
    ieeujefhueeigfegueehgeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoh
    eplhhkmhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgt
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprh
    gtphhtthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:k5PpZmjjdvtfnnTUMxyarIvVGtN8GdMkpiet04So6-LLONo4c8ojwg>
    <xmx:k5PpZqAHEvI5Qsczqkm_xhjIW9GQbQm-AzYSKanMgMCGZfqs0RZTdg>
    <xmx:k5PpZnKb7YwChUhJaTD_JVehHcBDdHXKX9ao5SKSMth3Y8v_b0or1w>
    <xmx:k5PpZhAtiRY7Dx0B77YyJRs3Tmb8XF0qz_kPg17U_I9Tou3KelXF-g>
    <xmx:k5PpZqxcVUppObEIIxuJguw4G4QXC1wazBBEkZMsdIRHmYCqObGjQplm>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Sep 2024 10:34:59 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com
Subject: [RFC PATCH 4/4] WIP: hazptr: Add hazptr test sample
Date: Tue, 17 Sep 2024 07:34:02 -0700
Message-ID: <20240917143402.930114-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240917143402.930114-1-boqun.feng@gmail.com>
References: <20240917143402.930114-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sample code for hazptr. This should go away or get more polished when
hazptr support is added into rcutorture.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 samples/Kconfig              |  6 +++
 samples/Makefile             |  1 +
 samples/hazptr/hazptr_test.c | 87 ++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 samples/hazptr/hazptr_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..9b42cde35dca 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -293,6 +293,12 @@ config SAMPLE_CGROUP
 
 source "samples/rust/Kconfig"
 
+config SAMPLE_HAZPTR
+	bool "Build hazptr sample code"
+	help
+	  Build samples that shows hazard pointer usage. Currently only
+	  builtin usage is supported.
+
 endif # SAMPLES
 
 config HAVE_SAMPLE_FTRACE_DIRECT
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..0be21edc8a30 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -39,3 +39,4 @@ obj-$(CONFIG_SAMPLE_KMEMLEAK)		+= kmemleak/
 obj-$(CONFIG_SAMPLE_CORESIGHT_SYSCFG)	+= coresight/
 obj-$(CONFIG_SAMPLE_FPROBE)		+= fprobe/
 obj-$(CONFIG_SAMPLES_RUST)		+= rust/
+obj-$(CONFIG_SAMPLE_HAZPTR)		+= hazptr/
diff --git a/samples/hazptr/hazptr_test.c b/samples/hazptr/hazptr_test.c
new file mode 100644
index 000000000000..3cf0cdc8a83a
--- /dev/null
+++ b/samples/hazptr/hazptr_test.c
@@ -0,0 +1,87 @@
+#include <linux/module.h>
+#include <linux/kthread.h>
+#include <linux/hazptr.h>
+
+struct foo {
+	int i;
+	struct callback_head head;
+};
+
+static void simple_func(struct callback_head *head)
+{
+	struct foo *ptr = container_of(head, struct foo, head);
+
+	printk("callback called %px, i is %d\n", ptr, ptr->i);
+	kfree(ptr);
+}
+
+static void simple(void)
+{
+	struct hazptr_context ctx;
+	struct foo *dummy, *tmp, *other;
+	hazptr_t *hptr;
+	hazptr_t *hptr2;
+
+	dummy = kzalloc(sizeof(*dummy), GFP_KERNEL);
+	dummy->i = 42;
+
+	other = kzalloc(sizeof(*dummy), GFP_KERNEL);
+	other->i = 43;
+
+	if (!dummy || !other) {
+		printk("allocation failed, skip test\n");
+		return;
+	}
+
+	init_hazptr_context(&ctx);
+	hptr = hazptr_alloc(&ctx);
+	BUG_ON(!hptr);
+
+	// Get a second hptr.
+	hptr2 = hazptr_alloc(&ctx);
+	BUG_ON(!hptr2);
+
+	// No one is modifying 'dummy', protection must succeed.
+	BUG_ON(!hazptr_tryprotect(hptr, dummy, head));
+
+	// Simulate changing a global pointer.
+	tmp = dummy;
+	WRITE_ONCE(dummy, other);
+
+	// Callback will run after no active readers.
+	printk("callback added, %px\n", tmp);
+
+	call_hazptr(&tmp->head, simple_func);
+
+	// No one is modifying 'dummy', protection must succeed.
+	tmp = hazptr_protect(hptr2, dummy, head);
+
+	printk("reader2 got %px, i is %d\n", tmp, tmp->i);
+
+	// The above callback should run after this.
+	hazptr_clear(hptr);
+	printk("first reader is out\n");
+
+	for (int i = 0; i < 10; i++)
+		schedule(); // yield a few times.
+
+	// Simulate freeing a global pointer.
+	tmp = dummy;
+	WRITE_ONCE(dummy, NULL);
+	printk("callback added, %px\n", tmp);
+	call_hazptr(&tmp->head, simple_func);
+
+	cleanup_hazptr_context(&ctx);
+	printk("no reader here\n");
+
+	for (int i = 0; i < 10; i++)
+		schedule(); // yield a few times.
+}
+
+static int hazptr_test(void)
+{
+	simple();
+	printk("test ends\n");
+	return 0;
+}
+module_init(hazptr_test);
-- 
2.45.2

