Return-Path: <SRS0=SldO=A6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F55C433E1
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 21:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2224220809
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 21:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uZ+G9Djy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgGSVF4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Jul 2020 17:05:56 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:38416 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSVFz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Jul 2020 17:05:55 -0400
Date:   Sun, 19 Jul 2020 21:05:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1595192753;
        bh=qrZnqAMSziWWv6HU1wN9x4QutwlZv+x/l4Ccary+jlQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=uZ+G9DjyNow6vL60r91B278l6K1NspTKPNQ+u6Uzzm18ys0904lmP8ZzoP9FX7B6m
         1hn9npomDrEe5SVv0m3RYVPJj19bQ4bBJYlp6t2Ft5H9rahGrCBXMr4A3ocE1hbepz
         a1UIwPtDeKLozkcxstwefb5tSdYoiY2Zi04i4S1o=
To:     paulmck@kernel.org, josh@joshtriplett.org
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     rcu@vger.kernel.org, Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH 2/2] rcu: Correct kernel-doc inconsistency
Message-ID: <20200719210533.152080-2-colton.w.lewis@protonmail.com>
In-Reply-To: <20200719210533.152080-1-colton.w.lewis@protonmail.com>
References: <20200719210533.152080-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Silence documentation build warnings by correcting kernel-doc comment
in hlists_swap_heads_rcu function.

./include/linux/rculist.h:515: warning: bad line:                          =
 [@right ][node2 ... ]

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index df587d181844..7eed65b5f713 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(struct hlist_node =
*old,
  * @right: The hlist head on the right
  *
  * The lists start out as [@left  ][node1 ... ] and
-                          [@right ][node2 ... ]
+ *                        [@right ][node2 ... ]
  * The lists end up as    [@left  ][node2 ... ]
  *                        [@right ][node1 ... ]
  */
--=20
2.26.2


