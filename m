Return-Path: <SRS0=/QKf=TY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC973C282E1
	for <rcu@archiver.kernel.org>; Fri, 24 May 2019 23:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B272D217F9
	for <rcu@archiver.kernel.org>; Fri, 24 May 2019 23:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FtBgIcfy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfEXXt4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 24 May 2019 19:49:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37379 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfEXXtz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 24 May 2019 19:49:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id n27so5852800pgm.4
        for <rcu@vger.kernel.org>; Fri, 24 May 2019 16:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWprfXxnZYwrSMlSa8B0jYY+Kk48KO4t7l+blfnMKTI=;
        b=FtBgIcfyzP/9kJsM+zqDbKcy6VZwEKAANCQ1/eZQrD6rviA4awDDcac9F6JHAeC8Ww
         /QISOXT5+haCwcCXiDtBTzmrbvUPQt/eQFfssAfxoublccYDf4cZJhSHGojIabZd0IPc
         VxKmmE96CtJBAuxlrRyraOLObouJSFe2WI5dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWprfXxnZYwrSMlSa8B0jYY+Kk48KO4t7l+blfnMKTI=;
        b=nYPV45oHKngDZUzr6E5k46PmP1St+zEUHhXwc25weOi9H15gLV1ohdA++EjU76+2SX
         0ndBmdOxo6LZe7xA79Y+3AofM1RqyD7xV3pZDLb7LStMEVVVlj99J7WVfENxa6IJ5Soy
         z4VsF17HvvZ/k0R3ZYrkVNF1NFYf2nBaZXTTIeUUm1k5RQfYWQc2xcZBS39h+nKs7sMQ
         EIzonOMuFk0NhDteOyUrtChFCiuJrqEgdFbZxMUEY1MkFfD7Jm+oo/Tr+pXGV2SQ70AP
         KrGhXXUdjVqh+ciKQz/qIexmiV+OlIgZGFYgvG5v8gLXzUE6dO6MHb2MSz1hn14tey4j
         A+TA==
X-Gm-Message-State: APjAAAUDegIC+IoCPgemtJFT4xv3SJDadgaER4nSTmWBjVMN1BMigNBr
        tvFg+94KsiMC9PdZy0lzyh+f7w==
X-Google-Smtp-Source: APXvYqz7Pfyyr4nOlV734fVH1bvjX4jHzTMPj1aZT0g/Pt0V2GglxzMFOH0INg1fPuB6UlDmRBFhmw==
X-Received: by 2002:a63:495e:: with SMTP id y30mr65431636pgk.185.1558741794604;
        Fri, 24 May 2019 16:49:54 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q4sm3297595pgb.39.2019.05.24.16.49.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 16:49:53 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC 1/5] powerpc: Use regular rcu_dereference_raw API
Date:   Fri, 24 May 2019 19:49:29 -0400
Message-Id: <20190524234933.5133-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190524234933.5133-1-joel@joelfernandes.org>
References: <20190524234933.5133-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcu_dereference_raw already does not do any tracing. There is no need to
use the _notrace variant of it and this series removes that API, so let us
use the regular variant here.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/powerpc/include/asm/kvm_book3s_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 21b1ed5df888..c15c9bbf0206 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -546,7 +546,7 @@ static inline void note_hpte_modification(struct kvm *kvm,
  */
 static inline struct kvm_memslots *kvm_memslots_raw(struct kvm *kvm)
 {
-	return rcu_dereference_raw_notrace(kvm->memslots[0]);
+	return rcu_dereference_raw(kvm->memslots[0]);
 }
 
 extern void kvmppc_mmu_debugfs_init(struct kvm *kvm);
-- 
2.22.0.rc1.257.g3120a18244-goog

