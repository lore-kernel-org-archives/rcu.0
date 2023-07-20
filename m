Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91733C001DC
	for <rcu@archiver.kernel.org>; Thu, 20 Jul 2023 16:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjGTQeh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 Jul 2023 12:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGTQeU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 Jul 2023 12:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02DF1FC8
        for <rcu@vger.kernel.org>; Thu, 20 Jul 2023 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689870803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5HBHaVT0pfIJAbbI8C24iwVVdenu59ApFnKMQXGGMQ=;
        b=PkTLPdFgleBGcxnnJQ8Tb0+vei7LSM4eGj6jWRj6xyCBPTfmDFltcVMLYaBYxXYc41Gve5
        09CPyfrMJap5knsTV5fiL2SYblhtRkydia5ATZicDi6d4zwVF38jZy/AC2yB/4a6rjGytN
        STzFqzVY5W0LUU51gy2xwUdQM8nFNeg=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-hhF8YKTPPJa4Xr8UF_kvXw-1; Thu, 20 Jul 2023 12:33:21 -0400
X-MC-Unique: hhF8YKTPPJa4Xr8UF_kvXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 679323815EF2;
        Thu, 20 Jul 2023 16:33:18 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F8940C206F;
        Thu, 20 Jul 2023 16:33:10 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: [RFC PATCH v2 10/20] jump_label,module: Don't alloc static_key_mod for __ro_after_init keys
Date:   Thu, 20 Jul 2023 17:30:46 +0100
Message-Id: <20230720163056.2564824-11-vschneid@redhat.com>
In-Reply-To: <20230720163056.2564824-1-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When a static_key is marked ro_after_init, its state will never change
(after init), therefore jump_label_update() will never need to iterate
the entries, and thus module load won't actually need to track this --
avoiding the static_key::next write.

Therefore, mark these keys such that jump_label_add_module() might
recognise them and avoid the modification.

Use the special state: 'static_key_linked(key) && !static_key_mod(key)'
to denote such keys.

Link: http://lore.kernel.org/r/20230705204142.GB2813335@hirez.programming.kicks-ass.net
NOT-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
@Peter: I've barely touched this patch, it's just been writing a comment
and fixing benign compilation issues, so credit's all yours really!
---
 include/asm-generic/sections.h |  5 ++++
 include/linux/jump_label.h     |  1 +
 init/main.c                    |  1 +
 kernel/jump_label.c            | 49 ++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index db13bb620f527..c768de6f19a9a 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -180,6 +180,11 @@ static inline bool is_kernel_rodata(unsigned long addr)
 	       addr < (unsigned long)__end_rodata;
 }
 
+static inline bool is_kernel_ro_after_init(unsigned long addr)
+{
+	return addr >= (unsigned long)__start_ro_after_init &&
+	       addr < (unsigned long)__end_ro_after_init;
+}
 /**
  * is_kernel_inittext - checks if the pointer address is located in the
  *                      .init.text section
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index f0a949b7c9733..88ef9e776af8d 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -216,6 +216,7 @@ extern struct jump_entry __start___jump_table[];
 extern struct jump_entry __stop___jump_table[];
 
 extern void jump_label_init(void);
+extern void jump_label_ro(void);
 extern void jump_label_lock(void);
 extern void jump_label_unlock(void);
 extern void arch_jump_label_transform(struct jump_entry *entry,
diff --git a/init/main.c b/init/main.c
index ad920fac325c3..cb5304ca18f4d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1403,6 +1403,7 @@ static void mark_readonly(void)
 		 * insecure pages which are W+X.
 		 */
 		rcu_barrier();
+		jump_label_ro();
 		mark_rodata_ro();
 		rodata_test();
 	} else
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index d9c822bbffb8d..661ef74dee9b7 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -530,6 +530,45 @@ void __init jump_label_init(void)
 	cpus_read_unlock();
 }
 
+static inline bool static_key_sealed(struct static_key *key)
+{
+	return (key->type & JUMP_TYPE_LINKED) && !(key->type & ~JUMP_TYPE_MASK);
+}
+
+static inline void static_key_seal(struct static_key *key)
+{
+	unsigned long type = key->type & JUMP_TYPE_TRUE;
+	key->type = JUMP_TYPE_LINKED | type;
+}
+
+void jump_label_ro(void)
+{
+	struct jump_entry *iter_start = __start___jump_table;
+	struct jump_entry *iter_stop = __stop___jump_table;
+	struct jump_entry *iter;
+
+	if (WARN_ON_ONCE(!static_key_initialized))
+		return;
+
+	cpus_read_lock();
+	jump_label_lock();
+
+	for (iter = iter_start; iter < iter_stop; iter++) {
+		struct static_key *iterk = jump_entry_key(iter);
+
+		if (!is_kernel_ro_after_init((unsigned long)iterk))
+			continue;
+
+		if (static_key_sealed(iterk))
+			continue;
+
+		static_key_seal(iterk);
+	}
+
+	jump_label_unlock();
+	cpus_read_unlock();
+}
+
 #ifdef CONFIG_MODULES
 
 enum jump_label_type jump_label_init_type(struct jump_entry *entry)
@@ -650,6 +689,15 @@ static int jump_label_add_module(struct module *mod)
 			static_key_set_entries(key, iter);
 			continue;
 		}
+
+		/*
+		 * If the key was sealed at init, then there's no need to keep a
+		 * a reference to its module entries - just patch them now and
+		 * be done with it.
+		 */
+		if (static_key_sealed(key))
+			goto do_poke;
+
 		jlm = kzalloc(sizeof(struct static_key_mod), GFP_KERNEL);
 		if (!jlm)
 			return -ENOMEM;
@@ -675,6 +723,7 @@ static int jump_label_add_module(struct module *mod)
 		static_key_set_linked(key);
 
 		/* Only update if we've changed from our initial state */
+do_poke:
 		if (jump_label_type(iter) != jump_label_init_type(iter))
 			__jump_label_update(key, iter, iter_stop, true);
 	}
-- 
2.31.1

