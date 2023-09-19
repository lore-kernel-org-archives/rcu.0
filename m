Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4260CCE79A9
	for <rcu@archiver.kernel.org>; Tue, 19 Sep 2023 19:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjISTtY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjISTtW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Sep 2023 15:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774658F
        for <rcu@vger.kernel.org>; Tue, 19 Sep 2023 12:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695152915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JECWNYIgvDcn1uBT/2hzcwjhsT52lJUN8GmMJpDdnx8=;
        b=ZCU50j2GupRCQM7aYWl9ijrdvuZZKhiu6Umju8eYwo0QuO82pz1EZKxj3OMs4jA7kLBmkK
        W8FP6KKvdMjANf+cJtqAUQyPSow01B4KjkAMpsjx7ik/fGqfnd8xGd3JBq9Cs53+OoE/23
        w6WvFfd1P5CZUlcJRNV/AQ+vMS1cerQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-YUoXb8yNPYCDOmqkDgCstA-1; Tue, 19 Sep 2023 15:48:33 -0400
X-MC-Unique: YUoXb8yNPYCDOmqkDgCstA-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-502d8606cebso1385204e87.1
        for <rcu@vger.kernel.org>; Tue, 19 Sep 2023 12:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695152912; x=1695757712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JECWNYIgvDcn1uBT/2hzcwjhsT52lJUN8GmMJpDdnx8=;
        b=eR6mIxEcKCWpBW1arepRwcr/jP8KnMuwVM7g4bmCyh8O9zF+XX09+MrNjWbqG8pcpj
         m6IJ7B2WQGZe9HXsB7ZEIxkjyVFf9K1W1F9uGgNgwWfQyBnirIie+P85wOvzOLG2LQ35
         IoEjgnVzLaV86eMzOm5vQPtZJJA7/1vcIaWl3jNZOpgd1Kp+O1c1BhIvE5zSkqPzJJm9
         haQuI4x77ZXKeigYlEzgxYt/mmpZa0DDeucIyJuwzMhsl+E9Qzd8a2Ia7J23RzKrOxoz
         F/DHEuFTED6KPQJmq7auY+4MRKfVLY3E4l+VcXJiQH3U62TMxlRqwq5DPGUK9bROJrRr
         Ev9w==
X-Gm-Message-State: AOJu0Yz8yI6Zo2EA8qaOg3kO/gDawVIVtFXR8OIwzeJv2SacX313/tEj
        HcOkgn+Zj4UoIdpt+hhygTlznia0bwTcYt+e4iZJ3Ev1mxEhk3fMNtG3A8NaF3uNQBDGtkJxu7p
        j5MWFOWVM7har
X-Received: by 2002:ac2:548b:0:b0:502:dbd0:6bc0 with SMTP id t11-20020ac2548b000000b00502dbd06bc0mr366653lfk.5.1695152912334;
        Tue, 19 Sep 2023 12:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7qCya6snF1XTMXLcBghcUd2E27xCSmtuh+zfOUuwITlCDoFsmvDQ/5bhi93AsTouFLj6RWw==
X-Received: by 2002:ac2:548b:0:b0:502:dbd0:6bc0 with SMTP id t11-20020ac2548b000000b00502dbd06bc0mr366645lfk.5.1695152911914;
        Tue, 19 Sep 2023 12:48:31 -0700 (PDT)
Received: from fedorinator.fritz.box ([2001:9e8:32ec:5700:c2e1:19c3:93f2:42ac])
        by smtp.gmail.com with ESMTPSA id cq8-20020a056402220800b00532d2b5126bsm875426edb.94.2023.09.19.12.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 12:48:31 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] rculist.h: docu: fix wrong function name
Date:   Tue, 19 Sep 2023 21:47:55 +0200
Message-ID: <20230919194754.20574-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The header contains a comment that details why the functions
list_empty_rcu() and list_first_entry_rcu() don't exist. It explains
that they don't exist because standard list_empty() can be used just as
well, but one can not expect sane results from a subsequent, quote,
"list_first_entry_rcu()".

This function (obviously) does not exist. What the comment's author
actually meant was the standard list-function list_first_entry().

Change the function name in that comment from list_first_entry_rcu() to
list_first_entry().

Additionally, add the parenthesis to list_first_or_null_rcu to be congruent
with that entire comment's style.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Hi!
I hope this helps.
I wasn't 100.000000% sure if that's correct, but I thought asking is for
free 8-)

Regards,
P.
---
 include/linux/rculist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index d29740be4833..4837d8892691 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -331,9 +331,9 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
  * rcu_dereference() is not needed), which means that list_empty() can be
  * used anywhere you would want to use list_empty_rcu().  Just don't
  * expect anything useful to happen if you do a subsequent lockless
- * call to list_first_entry_rcu()!!!
+ * call to list_first_entry()!!!
  *
- * See list_first_or_null_rcu for an alternative.
+ * See list_first_or_null_rcu() for an alternative.
  */
 
 /**
-- 
2.41.0

