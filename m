Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB1C7EE25
	for <rcu@archiver.kernel.org>; Mon, 12 Jun 2023 09:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjFLJ5E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 05:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjFLJyX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 05:54:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3E55FF0;
        Mon, 12 Jun 2023 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mq5JO2tPl8C7SILOfz/KwJIcnobnm9UFdJaARgXH410=; b=AMcWXrFAvQk7IooWq5vsQKOUpX
        c+43fYmu8uTkx0XjpUhBb5rLhhZTpeo7fFtrFQ6gX1Ie/h4dDKHWEhenT13VsLCQtYF4J8qBvnqTN
        Rb7fXamtrAdhJIYp7XX1thb9d5mecYu5DsgQSqMp7US340Et8Gvt1QM3WZU+8S6FEN+rhyMOUXAIr
        zrgte1I7kA8l7tRuTCoT+JXSeh785ZZ203dX7QWjb/gjzrBXnKJDRygq4P+8awKyHb5qZx9laV/87
        GV7BCj0gIl7rPXAFdcBqCQXcR9zo9IGdzN5vsPxOEsYOaEA/IqiNceS6vjnqf815nn9bTlK1cd3oY
        AFlkOulA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8e0f-002N8u-IH; Mon, 12 Jun 2023 09:38:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C280302680;
        Mon, 12 Jun 2023 11:38:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F111730A210B0; Mon, 12 Jun 2023 11:38:47 +0200 (CEST)
Message-ID: <20230612093537.536441207@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Jun 2023 11:07:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        peterz@infradead.org, mingo@redhat.com, longman@redhat.com,
        boqun.feng@gmail.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Subject: [PATCH v3 02/57] apparmor: Free up __cleanup() name
References: <20230612090713.652690195@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In order to use __cleanup for __attribute__((__cleanup__(func))) the
name must not be used for anything else. Avoid the conflict.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 security/apparmor/include/lib.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/security/apparmor/include/lib.h
+++ b/security/apparmor/include/lib.h
@@ -232,7 +232,7 @@ void aa_policy_destroy(struct aa_policy
  */
 #define fn_label_build(L, P, GFP, FN)					\
 ({									\
-	__label__ __cleanup, __done;					\
+	__label__ __do_cleanup, __done;					\
 	struct aa_label *__new_;					\
 									\
 	if ((L)->size > 1) {						\
@@ -250,7 +250,7 @@ void aa_policy_destroy(struct aa_policy
 			__new_ = (FN);					\
 			AA_BUG(!__new_);				\
 			if (IS_ERR(__new_))				\
-				goto __cleanup;				\
+				goto __do_cleanup;			\
 			__lvec[__j++] = __new_;				\
 		}							\
 		for (__j = __count = 0; __j < (L)->size; __j++)		\
@@ -272,7 +272,7 @@ void aa_policy_destroy(struct aa_policy
 			vec_cleanup(profile, __pvec, __count);		\
 		} else							\
 			__new_ = NULL;					\
-__cleanup:								\
+__do_cleanup:								\
 		vec_cleanup(label, __lvec, (L)->size);			\
 	} else {							\
 		(P) = labels_profile(L);				\


