Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACB4C3A5A0
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED5F205C9
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GRkRYA4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgDTPi5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgDTPiy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Apr 2020 11:38:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BEFC061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:38:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id l13so8805597qtr.7
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1kWcuYFn03hwVXwsvDY0f4HcUgS229FSxgRj7CnrJU=;
        b=GRkRYA4nO05KIZfWUlx1Eo+x5NW3avb7hx/R/BR3G0jVgX29Pul3Nht48oJBW8fVo6
         JMIUGRrYMOzX0e2InShPepFJHt6374ik6NwFQS04KBIebEj4hUrgH/o/CEAfO34vxEmv
         HQf3pmSe0TqHeHdxJopHSx9bN9+Ts3u0X814g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1kWcuYFn03hwVXwsvDY0f4HcUgS229FSxgRj7CnrJU=;
        b=UDm5Trv2ZJ09Pe8orGIma1ZGmgZfq64EG/RQShqYQEypCJnO2Ya5lCbKKXhAGF80q4
         wcM2a7Yw84uRdmg+HRLxxt07vPwJ+vHXsD6ekR7jE7pWET3wYtDHQac/jFIxBZ2XOO7K
         Ciw8tu2j/Qj9xQRWciEyosgc7y1lxevssB8i0fynYX2LJ+uA7Z1Pgfq5oZ/j8P8OIytk
         zps8lZir3NUAeYeaWFneHgo4NEHfTSuVk6AV32U2l4E2wYfnwB1PBMbjOFsfuLKCL0p8
         GbJlYo2Gv0+d/Xci9iVex7X97M1LT9b66gTNOj/u5veTy/bPi4bPRz6cotG5xpzan5W9
         wtqA==
X-Gm-Message-State: AGi0PubCC3PucyeAluWvLpS0zhlgMT3h+SqjZlkuE17BZ0bx6jIULs+C
        b/k4WUuVg5YPs7LvBs/XlQbT1g==
X-Google-Smtp-Source: APiQypIFwLhS3qC15R/u1QDQAimquSh3ehrcqoMeYptUaTq90YjjWzb50WK/CYBF0XbCAqTpP/xFuw==
X-Received: by 2002:ac8:6f17:: with SMTP id g23mr16655042qtv.266.1587397131782;
        Mon, 20 Apr 2020 08:38:51 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v16sm765453qkf.80.2020.04.20.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:38:51 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        bigeasy@linutronix.de, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [PATCH rcu/dev -fixes 0/4] 
Date:   Mon, 20 Apr 2020 11:38:33 -0400
Message-Id: <20200420153837.194532-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,
Some of these patches would prevent breakage on PREEMPT_RT. I have marked them
as "rcu/dev fixes". Please consider applying for v5.8. The exceptions are 3/4
and 4/4 which some small clean-ups. Thanks!

Joel Fernandes (Google) (3):
rcu/tree: Keep kfree_rcu() awake during lock contention
rcu/tree: Skip entry into the page allocator for PREEMPT_RT
rcu/tree: Use consistent style for comments

Sebastian Andrzej Siewior (1):
rcu/tree: Avoid using xchg() in kfree_call_rcu_add_ptr_to_bulk()

kernel/rcu/tree.c | 61 ++++++++++++++++++++++++++++-------------------
1 file changed, 37 insertions(+), 24 deletions(-)

--
2.26.1.301.g55bc3eb7cb9-goog

