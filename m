Return-Path: <SRS0=SldO=A6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1742C433E1
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 10:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B6C207DF
	for <rcu@archiver.kernel.org>; Sun, 19 Jul 2020 10:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/U2OuR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgGSKvA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 19 Jul 2020 06:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSKvA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 19 Jul 2020 06:51:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F9C0619D2;
        Sun, 19 Jul 2020 03:51:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so8520851pjq.5;
        Sun, 19 Jul 2020 03:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=i5Q3QT1Ih4QGY3ZrYvsBBkkl/Y6OC9HOiRLycKPMyv8=;
        b=Q/U2OuR8FUMLPV4JNzeDvDGLhB8qtVYlbq3MFF3Zy+OG0TevEHTh4sbfXupBifHqeJ
         slbGZtvl/tgTGV9N3g4UghhQ8zX63tfiptwUodDMKn6tb61tBmuWJDgdJAXKrJy9hLEu
         UPvIcB5ftGb6VVbgyxhcEOthTR4gqL4PGy6YRdDJ0KcI7FObRzpWozz/jbYPO+bq+8k/
         kzu5cL+ETR4TJbBZBxYVMgToVnrc8FSmSS1cIBRJL1R0yFVW2jk3XkHevoYTNt6xjCeO
         ZXgN+wgHNOt02iVR7ULgoTc5EM8CiTO4ZbjIORUW+voM3ux5MemNJdwKH2QBye/y8vj2
         VIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=i5Q3QT1Ih4QGY3ZrYvsBBkkl/Y6OC9HOiRLycKPMyv8=;
        b=rht+xu7V5ZmSt2mazZS4nprEICQnyo8i6+Zd15ejO814LWRDa/PZXxMVEy4FY4sgKW
         C47xei8o1luhtmlEJr8y9qpwbZf9mdD80UDK3dc103+DsAHnjq1OMlQdMtPBv3RuqJbQ
         9mlhZl5y1tU0uSRbBaljNrH4kcoaOk2I779fZmuNVbeiSIOGaLvA+c8pR0vomXnoSOJd
         /+NTWxrX2a9PYyUjSgnFz/sFcJ8g5phKM1biTkhNTwnioAZxXw31eoFgCjQ2cLRgyR9I
         Tmj3CHXvZS4MqsbmIkZgloY8Mg/hgi6LqjViR4oDyNcUnjhDtUj5UkBboW+MBknGez49
         g6bA==
X-Gm-Message-State: AOAM533tyx6WeKAdFIYxz4Jwr1FckyNWl/AmJefLn6KhlKK9h6IC6DVH
        RON5U1UCaW9CJaah0Nr/5sV+8boQEKZY1A==
X-Google-Smtp-Source: ABdhPJzHR8KcnFKbnPTv23C4skECP0GcpbH1f/DfXLdEXdEmj6WA6juq0sdc+xbr0d0Ay3oMvn4pNA==
X-Received: by 2002:a17:902:6506:: with SMTP id b6mr13367278plk.13.1595155859086;
        Sun, 19 Jul 2020 03:50:59 -0700 (PDT)
Received: from blackclown ([2405:204:219:61b6:3945:8436:8c57:56d5])
        by smtp.gmail.com with ESMTPSA id 83sm13150442pfu.60.2020.07.19.03.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Jul 2020 03:50:58 -0700 (PDT)
Date:   Sun, 19 Jul 2020 16:20:37 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, madhuparnabhowmik10@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rculist: Silence unused-value warning.
Message-ID: <20200719105037.GA21010@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The macro __list_check_srcu is used as a statement inside a for loop.

__list_check_srcu becomes "true" when CONFIG_PROVE_RCU_LIST is not defined.
This results in compiler warning about an unused value ("true").

Silence the compiler warning about the unused value "true"
by replacing it with an empty expression.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index de9385b9158e..8b8e0584c473 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *l=
ist)
 #define __list_check_rcu(dummy, cond, extra...)				\
 	({ check_arg_count_one(extra); })
=20
-#define __list_check_srcu(cond) true
+#define __list_check_srcu(cond) ({})
 #endif
=20
 /*
--=20
2.17.1


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl8UJXwACgkQ+gRsbIfe
74547A//eomBoSRcErXxtOyLJNattd6CO5iwalDPMtutCPgLCNih1Eb48svoyLh5
7aXtvXfyYaIsXilVifGxEznFDSIAAQp0wROmJ9eI61zUV407xLcOh1KWU7EN1tzz
dZ/Szq3v4v/8tbYqZb2IDIRbX3QCj0eIQvJ+kR3veBmOETRnEZAFn91XGna/LFOq
mcbTh53WY9e2C/NqsioiQ6rfdMgTawYa4JrgsEzNhF8g5lPGipH/f73B6PI7oc/q
fnKduWqyq4wON2BUUU47Uvzo6wOI4G+YkUAiB34bqLDv44UXzETuRKijzgJdKhSa
A6//xSEq3Am29T/ekgZIojUJyE3M62GEFSUFiS1Wo4Dqcqxmqb1dG8CMol9mtl06
TbWx6FYRsCos+vHUj9FBrd7Pa3fb0iWgiIzJgWhClwA8oskDuvomax0YQ9S41Vu8
SvULgxZyqDFaqBawnzuyCWFsB12XA7GXPUW3HayXEtz/GIesV7VuDTB4EsTZaZt/
unqQHNRcCDkO4w0kemZRJXL/wDmzT1meW9RbrexgtptH2BSE7OyOEtptIrgWs9Gt
eeE/IB8b6/fCuVKLXQtOpIjB+JP2JfY97Pb4EqDufXXNgKykOya2HU8IbCbj7nUu
Luta2BZlj/PA1g16IWb5ErE+Mobh66qir2KRQPO/lR6UJ0154BI=
=Kftb
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
