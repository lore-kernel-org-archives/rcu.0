Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3882C433EF
	for <rcu@archiver.kernel.org>; Thu, 25 Nov 2021 04:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhKYEqr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 23:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhKYEoq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 23:44:46 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CEEC061574;
        Wed, 24 Nov 2021 20:41:35 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id b67so8434642qkg.6;
        Wed, 24 Nov 2021 20:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UyUuOkxYpdVnZCGRGmG6yNWotEFjjwbnIhu+eCTBlDk=;
        b=HGfRVguEdswibJgeC/mhhfoRWmne+mY9m4t6/mr2Onmr0G+8CwJ05NMkmIr5dx8gxh
         MO3SH98fITQAXv6Fi6IPn0Omwjc2c1Kn9yT7cLF/0Y382hhJdvYvNza8VrtTW8TN0RTo
         dwQPdElQuRU/ZTNadLK1dK155Lyi02HMR/qDwO4ZrH3QU6U4REvg2WGqtwLV+P7sh8en
         E4PrxBk3zcBknjiJdr1D3LUMl7MnvHGjFmo2ty2ItdSfsXR8wBmh3gVpq64PTHK0BLgL
         xzhojCKYz4HHA2+hpLlunCkcM6aHQdB+Dea6Ex7nlGXnUXtnZB46BsdEsSG5h3jnMvvx
         SmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UyUuOkxYpdVnZCGRGmG6yNWotEFjjwbnIhu+eCTBlDk=;
        b=Fnd1SqfL0J68dJV5h/BXaSVEDruyRD7rLAv9sjE0QZ/X8W5sKnwg/sZulqF4T306HM
         K1hNujVXbA22QA5/WfN77a4OFWhufJ9iMX7WbsapxKjvdJq4VBip9DMYjEfXjSWCAvJ8
         Z0tZhfqsNlwrHEkCF+VzQISiZMB4f/pJLnFB3NrwD9JkCK6dl91vCr4EYODlluLfku9m
         S+aLqWfYzvbd/DpgTV+nsYvGamcugoO9gQzwOpPCeYilwq0/HT1d5MNS8Et/Lq1LmXAC
         H5qBRjm2kgb8cZN0agx5UWmJwREsGVPzzMx7vdz/eKNuEjpEquSBtj7T0XGx37aQ2zqp
         xcXw==
X-Gm-Message-State: AOAM532o9vvpV3mZ4wrYDw3M92fykuKRFtX8zU4sBivuoOvG0l8eiwqk
        22VzPfw/xhq9s7PR3E/2TYsMxv0boI8=
X-Google-Smtp-Source: ABdhPJy7qfimOxSr4/fMIE7a2D4KDer/6cV3LsKxzuCkCEJlgsMJJHGEPQorNf5S0C16PETlewJPqw==
X-Received: by 2002:a37:6682:: with SMTP id a124mr12157869qkc.110.1637815294759;
        Wed, 24 Nov 2021 20:41:34 -0800 (PST)
Received: from localhost ([66.216.211.25])
        by smtp.gmail.com with ESMTPSA id l25sm857260qkk.48.2021.11.24.20.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 20:41:34 -0800 (PST)
Date:   Wed, 24 Nov 2021 20:41:32 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 5/6] rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
Message-ID: <20211125044132.GA105778@lapt>
References: <20211123003708.468409-1-frederic@kernel.org>
 <20211123003708.468409-6-frederic@kernel.org>
 <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125004720.GV641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 24, 2021 at 04:47:20PM -0800, Paul E. McKenney wrote:
> On Tue, Nov 23, 2021 at 01:37:07AM +0100, Frederic Weisbecker wrote:
> > If a user wants to boot without any CPU in offloaded mode initially but
> > with the possibility to offload them later using cpusets, provide a way
> > to simply pass an empty "rcu_nocbs" kernel parameter which will enforce
> > the creation of dormant nocb kthreads.
> 
> Huh.  This would have been a use for Yury Norov's "none" bitmask
> specifier.  ;-)
> 
> I pulled this one in with the usual wordsmithing.
> 
> 							Thanx, Paul

I think 'rcu_nocbs=,' should work as 'none'. But I admit that it looks
awkward. The following patch adds clear 'none' semantics to the parser.
If you like it, I think you may drop non-documentation part of this
patch.

From e3a9cfe4830141c88aa5d8a93eae3512b2ae2882 Mon Sep 17 00:00:00 2001
From: Yury Norov <yury.norov@gmail.com>
Date: Wed, 24 Nov 2021 19:34:05 -0800
Subject: [PATCH] lib/bitmap: add 'none' specifier for bitmap_parselist()

Currently bitmap_parselist() has no clear notation to specify empty bitmap.
The format allows ',' or '0:0-N' for doing this, but it looks hacky.

Frederic Weisbecker needs to pass an empty rcu_nocbs to the kernel, and
without such a notation has to hack his own code:

https://lore.kernel.org/rcu/20211125005526.GA490855@lothringen/

This patch adds 'none' to the bitmap_parselist, so that no such hacks would
be needed. 'None' is case-insensitive and doesn't support group semantics
('none:1/2' is meaningless and wouldn't work).

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.rst |  7 +++++--
 lib/bitmap.c                                    | 12 +++++++++++-
 lib/test_bitmap.c                               | 13 +++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 01ba293a2d70..af261018bab5 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -76,11 +76,14 @@ to change, such as less cores in the CPU list, then N and any ranges using N
 will also change.  Use the same on a small 4 core system, and "16-N" becomes
 "16-3" and now the same boot input will be flagged as invalid (start > end).
 
+The special case-tolerant group name "none" has a meaning of selecting no CPUs,
+so that "rcu_nocps=none" would allow to disable offloading mode for all CPUs.
+
 The special case-tolerant group name "all" has a meaning of selecting all CPUs,
 so that "nohz_full=all" is the equivalent of "nohz_full=0-N".
 
-The semantics of "N" and "all" is supported on a level of bitmaps and holds for
-all users of bitmap_parse().
+The semantics of "none", "N" and "all" is supported on a level of bitmaps and
+holds for all users of bitmap_parse().
 
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
diff --git a/lib/bitmap.c b/lib/bitmap.c
index d7b80a069819..bcb38d055ec1 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -771,6 +771,16 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 		goto check_pattern;
 	}
 
+	if (!strncasecmp(str, "none", 4)) {
+		r->start = 0;
+		r->end = 0;
+		r->off = 0;
+		r->group_len = r->nbits;
+		str += 4;
+
+		goto out;
+	}
+
 	str = bitmap_getnum(str, &r->start, lastbit);
 	if (IS_ERR(str))
 		return str;
@@ -806,7 +816,7 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
 no_pattern:
 	r->off = r->end + 1;
 	r->group_len = r->end + 1;
-
+out:
 	return end_of_str(*str) ? NULL : str;
 }
 
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 0c82f07f74fc..1111d0d0df5f 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -351,18 +351,26 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, ",,  ,,  , ,  ,",		&exp1[12 * step], 8, 0},
 	{0, " ,  ,,  , ,   ",		&exp1[12 * step], 8, 0},
 	{0, " ,  ,,  , ,   \n",		&exp1[12 * step], 8, 0},
+	{0, "none",             	&exp1[12 * step], 8, 0},
+	{0, " , NONE ,,  , ,   \n",	&exp1[12 * step], 8, 0},
+	{0, " ,  ,none,  , ,   \n",	&exp1[12 * step], 8, 0},
+	{0, " ,  ,,  , ,none   \n",	&exp1[12 * step], 8, 0},
 
 	{0, "0-0",			&exp1[0], 32, 0},
 	{0, "1-1",			&exp1[1 * step], 32, 0},
 	{0, "15-15",			&exp1[13 * step], 32, 0},
 	{0, "31-31",			&exp1[14 * step], 32, 0},
+	{0, "31-31,none",		&exp1[14 * step], 32, 0},
 
 	{0, "0-0:0/1",			&exp1[12 * step], 32, 0},
+	{0, "0-0:0/1,none",		&exp1[12 * step], 32, 0},
 	{0, "0-0:1/1",			&exp1[0], 32, 0},
 	{0, "0-0:1/31",			&exp1[0], 32, 0},
 	{0, "0-0:31/31",		&exp1[0], 32, 0},
 	{0, "1-1:1/1",			&exp1[1 * step], 32, 0},
 	{0, "0-15:16/31",		&exp1[2 * step], 32, 0},
+	{0, "0-15:16/31,none",		&exp1[2 * step], 32, 0},
+	{0, "none,0-15:16/31",		&exp1[2 * step], 32, 0},
 	{0, "15-15:1/2",		&exp1[13 * step], 32, 0},
 	{0, "15-15:31/31",		&exp1[13 * step], 32, 0},
 	{0, "15-31:1/31",		&exp1[13 * step], 32, 0},
@@ -381,6 +389,7 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0, "0-N:1/3,1-N:1/3,2-N:1/3",		&exp1[8 * step], 32, 0},
 	{0, "0-31:1/3,1-31:1/3,2-31:1/3",	&exp1[8 * step], 32, 0},
 	{0, "1-10:8/12,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
+	{0, "1-10:8/12,none,8-31:24/29,0-31:0/3",	&exp1[9 * step], 32, 0},
 
 	{0,	  "all",		&exp1[8 * step], 32, 0},
 	{0,	  "0, 1, all,  ",	&exp1[8 * step], 32, 0},
@@ -388,6 +397,10 @@ static const struct test_bitmap_parselist parselist_tests[] __initconst = {
 	{0,	  "ALL:1/2",		&exp1[4 * step], 32, 0},
 	{-EINVAL, "al", NULL, 8, 0},
 	{-EINVAL, "alll", NULL, 8, 0},
+	{-EINVAL, "non", NULL, 8, 0},
+	{-EINVAL, "one", NULL, 8, 0},
+	{-EINVAL, "NONEE", NULL, 8, 0},
+	{-EINVAL, "NONE:1/2", NULL, 8, 0},
 
 	{-EINVAL, "-1",	NULL, 8, 0},
 	{-EINVAL, "-0",	NULL, 8, 0},
-- 
2.25.1


