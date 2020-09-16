Return-Path: <SRS0=+/rT=CZ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A77C43461
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 20:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 311F5206BE
	for <rcu@archiver.kernel.org>; Wed, 16 Sep 2020 20:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ifa6dtsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgIPUsi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgIPUsf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Sep 2020 16:48:35 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BAAC06174A
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2020 13:48:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t7so74609pjd.3
        for <rcu@vger.kernel.org>; Wed, 16 Sep 2020 13:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uPX6rKTdxLnDni+VW8OY4PDbBwwIGPh/qDCu4Axfn9Y=;
        b=Ifa6dtsWASq60dAP4HrHNhDkxjS/xmmyHGePZzYePu71a8jCV5+96pjCOedjPhMvxl
         N1QdvYLQQgbriQgd11wwOvLyhLa/p3nPBSvPA0voQ/Kcd5gJw7vGgP/GrjLjDogBj3Rs
         qH+9DeYYxHoAepS71WY+z3x0EWTwGCxGItyKQ8rf0ZYjg+v4yJNkK6sfhgSPQAFG8wRX
         HEfvRMQs75/ZPOc6KOlCXQosNvotAhyxDGcqBMRE9OMSbZhtWFOAIVCb2ibmLGmpBmwd
         6Ez4o4qxD6OvHnWv/pAiemG6fC3mVTcvalFfB9XpDyETbIQvTEqyHROqvOMuZASi9g44
         4rbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uPX6rKTdxLnDni+VW8OY4PDbBwwIGPh/qDCu4Axfn9Y=;
        b=OpoOIadQKpxTK/Ests4bzNdptjAnU4eqOQ3UUHSEY14cSb6pLOHrU9kTxrc0JsE8v/
         hCOkkKOugzrYUocHnE9xdOsLWJW581vSq6tW7vEa+bA83OwiRYVdCKY+r7jFO/QOl9R9
         Wt856JZb1fTuI1u9qFIW34uCZx412T4h6VgNknJeytUTIheQtWtqd2DHFoTCz8FsuPVh
         m6AvGg19+lz9JU7d1B3PGQ5I4p07ZrpFPIF4C5ePY8KHTnfuO4PVMTsqFxvFnAGzoq5R
         9GV0Qqlu4NpMTzgRG8FbofdzuViEihsTwp3KbXmEg41AqrRkmCqd8vctOEncgOHA2003
         MvPw==
X-Gm-Message-State: AOAM531/PwNX4X+NWVwxjROEaoNOK9gt/it+TUKc5zjLcbJr0D6oqPVq
        eTXgUdftwCXexs7dvcIw3+GpmBqB85XI/9vXwp6SzQ==
X-Google-Smtp-Source: ABdhPJyDCgq8DKDCdk2N/l6JAmDoALogXR6SSjWzCvffybXxW9Blsqexix21sT/EHvKtShppsmOjR3NfvIB3dpc39TI=
X-Received: by 2002:a17:902:c3d2:b029:d1:9bc8:15f8 with SMTP id
 j18-20020a170902c3d2b02900d19bc815f8mr24717552plj.29.1600289314507; Wed, 16
 Sep 2020 13:48:34 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 16 Sep 2020 13:48:22 -0700
Message-ID: <CAKwvOdm4AQhobdkKT08bjPGb15N58QN79XWxEaQt-P5Dk4+avQ@mail.gmail.com>
Subject: GPF from __srcu_read_lock() via drm_minor_acquire()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        jiangshanlai@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hey Paul and RCU folks,
I noticed we have a bug report from 2 users that seem to have similar
stack traces in SRCU code;
https://github.com/ClangBuiltLinux/linux/issues/1081

Is there a way we should go about starting to debug this?

-- 
Thanks,
~Nick Desaulniers
