Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA106C433ED
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 02:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A125C6121E
	for <rcu@archiver.kernel.org>; Fri, 21 May 2021 02:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhEUCRe (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 20 May 2021 22:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhEUCRd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 20 May 2021 22:17:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B45AC061574;
        Thu, 20 May 2021 19:16:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id s20so10148769plr.13;
        Thu, 20 May 2021 19:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fVzR5OVqDH21+KakLyQ1BmjTZqyPl6/nk9rsewhpUsQ=;
        b=M+zeTEoLI1/GYxmn5GOJHv/QEEKYeQxcWuZj9YJ9XB5FVShC3Q37jZR+nMsUOWQRPa
         tjc8ticmX6XmY+Fhq4+mCG/l5uwbyEtTG3Iex5XLkKeoqq6+eN21lYPnGaQNoixJi77r
         c/xZbyLgrMC263s59XTEuLtVwfWvY3fa+1ox3lOXnshpmLfe0102gK/JEz3yjfC8PSBR
         eD8XIBye5XZESvp1EV6EeHwI4kITe6qFuU0IpEpVfrioRks5WznTBJbPPU+3VT2jf998
         kyer0otHWNcpAgDo6NlOtARlTHVhc9vWjt+FfKsCiuQRpRbzzFnUBu199WPfVCc26Lgs
         TNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fVzR5OVqDH21+KakLyQ1BmjTZqyPl6/nk9rsewhpUsQ=;
        b=g7j2BXhCdBGGJssixRev8Ur2hbTwVDhwxFHu6jdZ668GrEHK8PsgipunvMcyETqM1Y
         2ePb7VtIijzXsqMJG/EcRA+gMbGVmHAmTzs8ZISeM2G0FE6kpeyx89TA1hFTaSCg3sxw
         UnU0voz/90XsrhWNg9KrzQGWKQCfRrLpRYdix3gRJgS3QoRe6kvMIOQvCcpnNZyI9thM
         8A57mWV5zkkymznWnLi36yLB+5uuIMWXjqBeKlmZRjzS3IUxJABB/W1p4RSE+mu9FVNZ
         /P3l2IXp5STml09sKhMGL7ud5P/UdsMvrfJ8t2YUkWCb5xMRSOB+9rWTF94EiNDXAotN
         Eqrg==
X-Gm-Message-State: AOAM530kdFG+RZiQNob/ZvEakFaXvWq9qEN80vm6U/muUZRszpGukSIe
        1l93mui3lA8JqlgyfQvReIc=
X-Google-Smtp-Source: ABdhPJz1/Z+AXBrAyurv/F0sH5f5HiGnIKoys49PW6W/IZ8autG8bmKbnH7X5qNzegikiUxhACOmHQ==
X-Received: by 2002:a17:902:65:b029:ef:abd6:477f with SMTP id 92-20020a1709020065b02900efabd6477fmr9291652pla.77.1621563368879;
        Thu, 20 May 2021 19:16:08 -0700 (PDT)
Received: from [192.168.11.2] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id o3sm3016891pgh.22.2021.05.20.19.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 19:16:08 -0700 (PDT)
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH -rcu] Documentation/RCU: Fix nested inline markup
Message-ID: <e23acc77-8b10-493e-63fa-76150be325f9@gmail.com>
Date:   Fri, 21 May 2021 11:16:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

To avoid the ``foo`` markup inside the `bar`__ hyperlink marker,
use the "replace" directive [1].

This should restore the intended appearance of the link.

Tested with sphinx versions 1.7.9 and 2.4.4.

[1]: https://docutils.sourceforge.io/docs/ref/rst/directives.html#replace

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
Hi Paul,

This fixes broken-looking cross reference in section
"Publish/Subscribe Guarantee" at:

https://www.kernel.org/doc/html/latest/RCU/Design/Requirements/Requirements.html#publish-subscribe-guarantee

To-be-replaced macro string can be much shorter.
I preserved the whole string considering the readability of .rst.

        Thanks, Akira
--
 Documentation/RCU/Design/Requirements/Requirements.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 38a39476fc24..45278e2974c0 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -362,9 +362,8 @@ do_something_gp() uses rcu_dereference() to fetch from ``gp``:
       12 }
 
 The rcu_dereference() uses volatile casts and (for DEC Alpha) memory
-barriers in the Linux kernel. Should a `high-quality implementation of
-C11 ``memory_order_consume``
-[PDF] <http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf>`__
+barriers in the Linux kernel. Should a |high-quality implementation of
+C11 memory_order_consume [PDF]|_
 ever appear, then rcu_dereference() could be implemented as a
 ``memory_order_consume`` load. Regardless of the exact implementation, a
 pointer fetched by rcu_dereference() may not be used outside of the
@@ -374,6 +373,9 @@ element has been passed from RCU to some other synchronization
 mechanism, most commonly locking or `reference
 counting <https://www.kernel.org/doc/Documentation/RCU/rcuref.txt>`__.
 
+.. |high-quality implementation of C11 memory_order_consume [PDF]| replace:: high-quality implementation of C11 ``memory_order_consume`` [PDF]
+.. _high-quality implementation of C11 memory_order_consume [PDF]: http://www.rdrop.com/users/paulmck/RCU/consume.2015.07.13a.pdf
+
 In short, updaters use rcu_assign_pointer() and readers use
 rcu_dereference(), and these two RCU API elements work together to
 ensure that readers have a consistent view of newly added data elements.
-- 
2.17.1

