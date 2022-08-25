Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6857C04AA5
	for <rcu@archiver.kernel.org>; Thu, 25 Aug 2022 02:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiHYC4G (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Aug 2022 22:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiHYC4G (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Aug 2022 22:56:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35D9DF96
        for <rcu@vger.kernel.org>; Wed, 24 Aug 2022 19:56:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a15so14213854qko.4
        for <rcu@vger.kernel.org>; Wed, 24 Aug 2022 19:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=p2GbpmYJgjV2N881UGR0VWD4BcfHaSZy8YTSUqUtlwE=;
        b=AIFtsz6fvKf9Zc8bACH9V1Jpfq/1Rj/tIQpXXBDKeXMv0DwwiblKBsreVWQCzDEfqE
         GwPza+60nwCvbbFL3VxY/5dH2q+lZ2Uy5cIVihg31TOnpRQ2rUgIjlKb6LZAs1VQpD5F
         zhLhou9O5ylVqcchX/4GgJ6zWAbGJaKlbvBqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=p2GbpmYJgjV2N881UGR0VWD4BcfHaSZy8YTSUqUtlwE=;
        b=qGFuxDLw49c8tS5BAcUKe5SDv2gIcJsN6H2kQwJ2hMSB8E8wLhks/3/ZFlqg/iQZd3
         FTR3Q0hC2vCOVQ1gkfHzXkrTqw8rL3Fe748YNSIbXkBcoEOkU7f8sHYzgPznCFi1TxlH
         yvaA/5N7W2zOMKHD8/jc9/fsJCYAiPgEozz1vQqz9Q/wdjLuzbBcQPgqNjxbKiGZxZo4
         3aBF85KPvM6kcnQ9m1Qf3bzICIS9JnKoSAOeM9TC9bncxHjFCJW8oSZynNxUrCeyT4IZ
         cZ+1UW2tqKAX3ViIDX7qcHoN9X0Ajnb2dG7kYRKam5xSkVVDG1LPGaXhJOXAiFWvoBKv
         G33Q==
X-Gm-Message-State: ACgBeo1T6WA2t2qFcfJULn5KkI86nNfDBPT2e+ZxncvWmNqNT2Mjkw6+
        TWebtmRA1DGOIAbq/srFJbAINQ==
X-Google-Smtp-Source: AA6agR7SnUtF1dbnk0cQr/GjTQ8nmmOLGApC69IqSxYCik7tcgB0RH+WpC9j+SPOep0F8XSDNBv1Rw==
X-Received: by 2002:a05:620a:1919:b0:6bb:6778:ea80 with SMTP id bj25-20020a05620a191900b006bb6778ea80mr1634269qkb.41.1661396163668;
        Wed, 24 Aug 2022 19:56:03 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id f3-20020ac80683000000b00339163a06fcsm13668334qth.6.2022.08.24.19.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 19:56:03 -0700 (PDT)
Message-ID: <85afd876-d8bb-0804-b2c5-48ed3055e702@joelfernandes.org>
Date:   Wed, 24 Aug 2022 22:56:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     vbabka@suse.cz, willy@infradead.org, paulmck@kernel.org,
        rcu <rcu@vger.kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Subject: How to increase rcu_head size without breaking -mm ?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,
I am trying to add some debug information to rcu_head for some patches, and need
your help! At least this used to work some time ago (> 1 year).

I get various SLAB_MATCH() errors with a change like this:

diff --git a/include/linux/types.h b/include/linux/types.h
index ea8cf60a8a79..daf7682a7a3b 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -220,6 +220,7 @@ struct ustat {
 struct callback_head {
        struct callback_head *next;
        void (*func)(struct callback_head *head);
+       char buf[4];
 } __attribute__((aligned(sizeof(void *))));
 #define rcu_head callback_head
---

Errors:
mm/slab.h:67:9: note: in expansion of macro ‘static_assert’
   67 |         static_assert(offsetof(struct page, pg) == offsetof(struct slab,
sl))
      |         ^~~~~~~~~~~~~
mm/slab.h:73:1: note: in expansion of macro ‘SLAB_MATCH’
   73 | SLAB_MATCH(_refcount, __page_refcount);
      | ^~~~~~~~~~

----------

I tried various things like increasing the struct slab or struct page size using
dummy variables, but nothing gives.

I tried to print the offsets of the struct using the compiler, but that requires
compilation to actually succeed. The same exercise with a pre-processor also
does not help because nested structures could also including rcu_heads.

If I at least knew how the offsets were off, I could hack it for my needs (of
course upstreaming such a change is a different story, but I do want to upstream
some variant of rcu_head debug info).

Any thoughts on how we can accomplish this?

Thanks!

 - Joel
