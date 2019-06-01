Return-Path: <SRS0=rUB2=UA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5EDC28CC5
	for <rcu@archiver.kernel.org>; Sat,  1 Jun 2019 22:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE484277AC
	for <rcu@archiver.kernel.org>; Sat,  1 Jun 2019 22:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cAGodZzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfFAW2H (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 1 Jun 2019 18:28:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36308 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfFAW2F (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 1 Jun 2019 18:28:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so6059118pgb.3
        for <rcu@vger.kernel.org>; Sat, 01 Jun 2019 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPaZRgyzQF7DCy2Q79gveolqcRd2gZR4xnQeESxSxI8=;
        b=cAGodZzSRsQMt/+agP3IVTRjmy7GJn9PFgRKDBVOfndMOmU790nOh6r8RDl2NSEttn
         ozggt0Vl0AEPviZREUImDWgpoB8D77NfGsskgK/Bj9R0lxq+Xa1zB1Rz3dBJYKQUD7bL
         uSS2mFmHddK5rTGvh+vSHZuyEX0sX9MRSOJjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPaZRgyzQF7DCy2Q79gveolqcRd2gZR4xnQeESxSxI8=;
        b=OBw6c/fwo0CpZsRdoo1dHN3qLJ2Aaj++L0n+GCgnzJyS4p3+BA89G56yEEPI/bbPCQ
         ssEyw+sB7e41ilxsA8FNyLh4kLJu3dBdAjjrm/e57KIEtkMXA6GjNkq9TIYex3AhkPiU
         rtrSTeYaLQUdL2roFJhS63RwIo6qbRt3WXPBq9wFMru1pkrXGOY7bmInDGQL2NISYioq
         DE3Keb5wp0neFkKSz9lDB0OHCVGPbL5fc9Eea9/OK3OdlZ8DSnscf7Dq6HwEiW8mz+36
         pQ+UGXDHU4Sd8Ep9w5fEVd/2CXXpM8dls3NOWA40MgcF8yKesWn1SHZtxxPSyI+gitHN
         JDpQ==
X-Gm-Message-State: APjAAAW/2kdUOovBfVj8diCu2EezIFxtOY9/qcI1scyLfZSfavsDwsxb
        XyqRozU/NmiJh73XCQIse1y0Ug==
X-Google-Smtp-Source: APXvYqx/DSML7hGGCdUoQbZcef6z1i2E+ZJBXAJvbUYli+Bo+0PJ9dMusQpxsqpBr79TPzH4e5AIzA==
X-Received: by 2002:a65:5206:: with SMTP id o6mr18823746pgp.248.1559428084316;
        Sat, 01 Jun 2019 15:28:04 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t33sm9908018pjb.1.2019.06.01.15.28.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 01 Jun 2019 15:28:03 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [RFC 5/6] x86/pci: Pass lockdep condition to pcm_mmcfg_list iterator
Date:   Sat,  1 Jun 2019 18:27:37 -0400
Message-Id: <20190601222738.6856-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190601222738.6856-1-joel@joelfernandes.org>
References: <20190601222738.6856-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The pcm_mmcfg_list is traversed with list_for_each_entry_rcu without a
reader-lock held, because the pci_mmcfg_lock is already held. Make this
known to the list macro so that it fixes new lockdep warnings that
trigger due to lockdep checks added to list_for_each_entry_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/pci/mmconfig-shared.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 7389db538c30..6fa42e9c4e6f 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -29,6 +29,7 @@
 static bool pci_mmcfg_running_state;
 static bool pci_mmcfg_arch_init_failed;
 static DEFINE_MUTEX(pci_mmcfg_lock);
+#define pci_mmcfg_lock_held() lock_is_held(&(pci_mmcfg_lock).dep_map)
 
 LIST_HEAD(pci_mmcfg_list);
 
@@ -54,7 +55,7 @@ static void list_add_sorted(struct pci_mmcfg_region *new)
 	struct pci_mmcfg_region *cfg;
 
 	/* keep list sorted by segment and starting bus number */
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list, pci_mmcfg_lock_held()) {
 		if (cfg->segment > new->segment ||
 		    (cfg->segment == new->segment &&
 		     cfg->start_bus >= new->start_bus)) {
@@ -118,7 +119,7 @@ struct pci_mmcfg_region *pci_mmconfig_lookup(int segment, int bus)
 {
 	struct pci_mmcfg_region *cfg;
 
-	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
+	list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list, pci_mmcfg_lock_held())
 		if (cfg->segment == segment &&
 		    cfg->start_bus <= bus && bus <= cfg->end_bus)
 			return cfg;
-- 
2.22.0.rc1.311.g5d7573a151-goog

