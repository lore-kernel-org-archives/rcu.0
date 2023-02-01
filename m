Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE9DC636D4
	for <rcu@archiver.kernel.org>; Wed,  1 Feb 2023 20:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBAUo4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Feb 2023 15:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBAUoz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Feb 2023 15:44:55 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD177DE5
        for <rcu@vger.kernel.org>; Wed,  1 Feb 2023 12:44:50 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h16so18468588wrz.12
        for <rcu@vger.kernel.org>; Wed, 01 Feb 2023 12:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVGzQu3A2f4Qgo78q6jxGuOz9gIN1MMwXavNYjSHKBU=;
        b=1pmygf+5X1mOOTRudl4VcLIfZwAStujjk3QFGa6j7KBal48TQf/affncmOD3//kkMI
         rcmGFccJCavXlkXytWAbcm6emsOHDwsjt6vCZUF43+rfAZGCQ79xzEj6NExy3AWl2TIH
         yqq4qgKbDrRXWSdk/Q6LTGijK2ZwPQRhSwcI44pdzEE7QTuapkzHDgxfAFcajF4pFeiU
         c+DydIzDTjs9qzHUYHbj4pjAqVKeSBkn3qUBcz10GgDBL1+qKVKQYV54cTXisUVhB59K
         zisPp3vUaSdjviwrmlQIpnH9yGM9tfJ3vGj1rRhx0PEZ2z+5ua/QBLLFDvzwKxEmVQh9
         qy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVGzQu3A2f4Qgo78q6jxGuOz9gIN1MMwXavNYjSHKBU=;
        b=6jplB8dVYQ7hOC/sIH5Yi2kI8fKrGwZ5J4CRFBnn8zGiAbaF72WEyqv3Kixmq/NS4B
         vqoUlH7oR2tscVj3wtsGRUZBgw+1CFVIl7B8Ld8I1Df4CTTr7EuOyrykRWI5BwU0zCoU
         jaR5f+yRCzhxcUxPNW8J94AgzsNDSIhEp4i/LnTa9jJhxFXlyv0atdm3RaLmSwPWL1Iz
         SapodlBlnWlA3x9jIBmD5H3PQk90/QM5Dzcjm4S7hejqwT6m9XB41KNKvf1tWgllhIgz
         7IAbpy/nqLTcISABQeJvgr6l2WOduJr5qpdFNMYLDOhtS2Q5J9tBq5qJYBG4ofgbQYf6
         KlOQ==
X-Gm-Message-State: AO0yUKXPS1jWNRoXUFuXRh8x89SLY20vh4U5lZURjrH4BrDlKibkKCnd
        JhdZ4b6CYa84dgMBBAzPs4Qjrg==
X-Google-Smtp-Source: AK7set8mJWiWAyJ74ti7VNQuSfGVVgfkF41VUhLW8nQG2B3Y90nuZ7EqdpXgzcSEUSguB8Fe2CwcUg==
X-Received: by 2002:a05:6000:1004:b0:2bf:d332:e123 with SMTP id a4-20020a056000100400b002bfd332e123mr3000451wrx.62.1675284288852;
        Wed, 01 Feb 2023 12:44:48 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6a:b566:0:7611:c340:3d8d:d46c])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d598f000000b002bdff778d87sm19993584wri.34.2023.02.01.12.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 12:44:48 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     dwmw2@infradead.org, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, rcu@vger.kernel.org, mimoja@mimoja.de,
        hewenliang4@huawei.com, thomas.lendacky@amd.com, seanjc@google.com,
        pmenzel@molgen.mpg.de, fam.zheng@bytedance.com,
        punit.agrawal@bytedance.com, simon.evans@bytedance.com,
        liangma@liangbit.com, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 2/9] cpu/hotplug: Move idle_thread_get() to <linux/smpboot.h>
Date:   Wed,  1 Feb 2023 20:43:31 +0000
Message-Id: <20230201204338.1337562-3-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230201204338.1337562-1-usama.arif@bytedance.com>
References: <20230201204338.1337562-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

Instead of relying purely on the special-case wrapper in bringup_cpu()
to pass the idle thread to __cpu_up(), expose idle_thread_get() so that
the architecture code can obtain it directly when necessary.

This will be useful when the existing __cpu_up() is split into multiple
phases, only *one* of which will actually need the idle thread.

If the architecture code is to register its new pre-bringup states with
the cpuhp core, having a special-case wrapper to pass extra arguments is
non-trivial and it's easier just to let the arch register its function
pointer to be invoked with the standard API.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 include/linux/smpboot.h | 7 +++++++
 kernel/smpboot.h        | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/smpboot.h b/include/linux/smpboot.h
index 9d1bc65d226c..3862addcaa34 100644
--- a/include/linux/smpboot.h
+++ b/include/linux/smpboot.h
@@ -5,6 +5,13 @@
 #include <linux/types.h>
 
 struct task_struct;
+
+#ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
+struct task_struct *idle_thread_get(unsigned int cpu);
+#else
+static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
+#endif
+
 /* Cookie handed to the thread_fn*/
 struct smpboot_thread_data;
 
diff --git a/kernel/smpboot.h b/kernel/smpboot.h
index 34dd3d7ba40b..60c609318ad6 100644
--- a/kernel/smpboot.h
+++ b/kernel/smpboot.h
@@ -5,11 +5,9 @@
 struct task_struct;
 
 #ifdef CONFIG_GENERIC_SMP_IDLE_THREAD
-struct task_struct *idle_thread_get(unsigned int cpu);
 void idle_thread_set_boot_cpu(void);
 void idle_threads_init(void);
 #else
-static inline struct task_struct *idle_thread_get(unsigned int cpu) { return NULL; }
 static inline void idle_thread_set_boot_cpu(void) { }
 static inline void idle_threads_init(void) { }
 #endif
-- 
2.25.1

