Return-Path: <SRS0=YgaY=B7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FFAC433E1
	for <rcu@archiver.kernel.org>; Fri, 21 Aug 2020 01:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0D820720
	for <rcu@archiver.kernel.org>; Fri, 21 Aug 2020 01:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="haHeMnAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHUBJT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgHUBJR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 Aug 2020 21:09:17 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24029C061385
        for <rcu@vger.kernel.org>; Thu, 20 Aug 2020 18:09:17 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id AE16A891B2;
        Fri, 21 Aug 2020 13:09:05 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1597972145;
        bh=SboNghHEGir+9hqaNMYgaTPiRt845ZwRlJOlc2Xx2pY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=haHeMnAf1vAq+oCBz+YkKnKWhP3xeVW1RChhgkzT947Vh3OPaWyog8e7EdHZRxoNx
         E4VULOp3ArYeStnKtkJdCg+KQ3ks12XiNQbZ8LwSBSxcPB1YDP7g21stQAZt+aVC4d
         L9TNJ2gTEIDwMbkd1DQuWgba4g/eyy3L0ufB2KCc1uVZ9C6/NawK+LRbkt10FEezTz
         0KpIjZWK+1DPyOliQKdYYOylq+bVYE5qB3oxmW8HeeHnW0ioPAeyKaPWrvcdbb0MNc
         Qpl48bQ0XQYlUJgETlb3b3ruwyF0NiJ+GtAK8WktQn8KMNHWqjKr8/WiFcLHgV0suV
         uJ1j7K8BiTTsg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f3f1eb10002>; Fri, 21 Aug 2020 13:09:05 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 6795213ED33;
        Fri, 21 Aug 2020 13:09:04 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 8444A283B16; Fri, 21 Aug 2020 13:09:05 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 2/2] docs: RCU: Remove stray ()
Date:   Fri, 21 Aug 2020 13:09:00 +1200
Message-Id: <20200821010900.6362-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821010900.6362-1-chris.packham@alliedtelesis.co.nz>
References: <20200821010900.6362-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

A reference to srcu_read_lock_held() had an extra (). Remove it,

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 Documentation/RCU/lockdep.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rs=
t
index f1fc8ae3846a..cc860a0c296b 100644
--- a/Documentation/RCU/lockdep.rst
+++ b/Documentation/RCU/lockdep.rst
@@ -49,7 +49,7 @@ checking of rcu_dereference() primitives:
 		is invoked by both RCU-sched readers and updaters.
 	srcu_dereference_check(p, c):
 		Use explicit check expression "c" along with
-		srcu_read_lock_held()().  This is useful in code that
+		srcu_read_lock_held().  This is useful in code that
 		is invoked by both SRCU readers and updaters.
 	rcu_dereference_raw(p):
 		Don't check.  (Use sparingly, if at all.)
--=20
2.28.0

