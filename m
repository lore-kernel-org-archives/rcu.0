Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A69C433EF
	for <rcu@archiver.kernel.org>; Fri, 17 Dec 2021 10:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhLQK6G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Dec 2021 05:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235145AbhLQK6F (ORCPT
        <rfc822;rcu@vger.kernel.org>); Fri, 17 Dec 2021 05:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639738685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfMj5Cdv9ABQA5uXGp3mACXyYa8FBWK9SwauD15vTUk=;
        b=BoUMBBoh2iJsBkoLtGf/SOxztI8HRRCUp3lG32MB9suUwqRNG5ZAMXPTQmHeR6hso28fr2
        +JKP42lLoQGFfmOyiSgmUEWiPdBK8ZyAWR6PdrJPZ+X4z4ZGwt2cPf7ODj5sdXilieiwRJ
        3gg3OvpgLuXQcI7BBShWnYWpjjqhAd4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-k9bRLql8M6e5wUU0ewTGyA-1; Fri, 17 Dec 2021 05:58:03 -0500
X-MC-Unique: k9bRLql8M6e5wUU0ewTGyA-1
Received: by mail-wm1-f71.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso2763674wme.8
        for <rcu@vger.kernel.org>; Fri, 17 Dec 2021 02:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfMj5Cdv9ABQA5uXGp3mACXyYa8FBWK9SwauD15vTUk=;
        b=3VwI/ws2sU39W3SUBCN769ca5Qec7+YRbFj1dDW1BNPbw/apVN8zuhKEYrpPldQ5xt
         Ozl8tv3zlPYteWyrNJ62gzbmyP44tTWNqEisCLscezOY3EKzwv9huUCWeh4I+tXsU/lg
         IF7IBKGOmnv/E8cLXgyKF9qt2QKenlxgoFXtCFrplJ0PeSjmu3jD+KrxiOcZH7gF5BDQ
         8ql0Ph9bKkQK3UDtoAbeFbYoJ1qGbot7bfs74wurXwptoozazEa805gO60MuodrnvbT8
         7PobV7zK+LnaF+t2Sf7vxoBsm8vT1zPmHMgvPJwrj1BX1KZRx3g5S1wveJwZ1elLJl1z
         nw0Q==
X-Gm-Message-State: AOAM531sleCKcX6Y4+xX631zAZmTfvKjd21egkvDNnf1Gkbplxq+Ng+j
        qFJ5dfBczWaUbzaZiccaNoqTX1mrCKZwCwsLqtC68EDYJA+r8TsX1RY+IN/J/wftBeD3vKJPP12
        +ZnE0DUfIh0IY
X-Received: by 2002:a05:600c:3ac6:: with SMTP id d6mr2240069wms.191.1639738682586;
        Fri, 17 Dec 2021 02:58:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysepd7uhQTf9/QJszbG/jm5Yl980CRUzB5yGgrcxWsh+7XsGwRjPoBHPcTl4LGXQFGL0ZYgQ==
X-Received: by 2002:a05:600c:3ac6:: with SMTP id d6mr2240054wms.191.1639738682352;
        Fri, 17 Dec 2021 02:58:02 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:3b0e:bd00:1099:cf34:d27f:de8a])
        by smtp.gmail.com with ESMTPSA id h5sm7405122wrz.63.2021.12.17.02.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 02:58:02 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     tglx@linutronix.de, mark.rutland@arm.com, paulmck@kernel.org
Cc:     rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
        peterz@infradead.org, mtosatti@redhat.com, frederic@kernel.org,
        corbet@lwn.net, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v3 2/2] Documentation: core-api: entry: Add comments about nesting
Date:   Fri, 17 Dec 2021 11:57:53 +0100
Message-Id: <20211217105753.892855-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217105753.892855-1-nsaenzju@redhat.com>
References: <20211217105753.892855-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The topic of nesting and reentrancy in the context of early entry code
hasn't been addressed so far. So do it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

---

NOTE: I moved this into a separate patch to simplify the review.

 Documentation/core-api/entry.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index 3f80537f2826..f665f201ead0 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -105,6 +105,8 @@ has to do extra work between the various steps. In such cases it has to
 ensure that enter_from_user_mode() is called first on entry and
 exit_to_user_mode() is called last on exit.
 
+Syscalls shouldn't nest. If it were to happen, RCU / context tracking will
+catch the misbehavior and print out a warning.
 
 KVM
 ---
@@ -121,6 +123,9 @@ Task work handling is done separately for guest at the boundary of the
 vcpu_run() loop via xfer_to_guest_mode_handle_work() which is a subset of
 the work handled on return to user space.
 
+Nesting doesn't make sense in the context of KVM entry/exit transitions, it
+shouldn't happen.
+
 Interrupts and regular exceptions
 ---------------------------------
 
@@ -180,6 +185,16 @@ before it handles soft interrupts, whose handlers must run in BH context rather
 than irq-disabled context. In addition, irqentry_exit() might schedule, which
 also requires that HARDIRQ_OFFSET has been removed from the preemption count.
 
+Even though interrupt handlers are expected to run with local interrupts
+disabled, interrupt nesting is common from an entry/exit perspective. For
+example, softirq handling happens within an irqentry_{enter,exit}() block, with
+local interrupts enabled. Also, although uncommon, nothing prevents an
+interrupt handler from re-enabling interrupts.
+
+Interrupt entry/exit code doesn't strictly need to handle reentrancy, since it
+runs with local interrupts disabled. But NMIs can happen anytime, and a lot of
+the entry code is shared between the two.
+
 NMI and NMI-like exceptions
 ---------------------------
 
@@ -259,3 +274,7 @@ and for e.g. a debug exception it can look like this:
 
 There is no combined irqentry_nmi_if_kernel() function available as the
 above cannot be handled in an exception-agnostic way.
+
+NMIs can happen in any context. For example, an NMI-like exception triggered
+while handling an NMI. So NMI entry code has to be reentrant and state updates
+need to handle nesting.
-- 
2.33.1

