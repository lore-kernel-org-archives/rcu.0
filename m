Return-Path: <SRS0=Tqm2=V3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7ECC32750
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E74206A2
	for <rcu@archiver.kernel.org>; Tue, 30 Jul 2019 23:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MoTEa90j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfG3XKm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Jul 2019 19:10:42 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:40697 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfG3XKm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 30 Jul 2019 19:10:42 -0400
Received: by mail-pf1-f170.google.com with SMTP id p184so30609329pfp.7
        for <rcu@vger.kernel.org>; Tue, 30 Jul 2019 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMAGuu53qq71mkY/dOmSePxlYMgR7q2jwJRIFacTZR4=;
        b=MoTEa90jICHzSc9qjZVoXVjbhgfPIwQxVoUmnzBO+/jwc1ZXZP7xkmkT+FKzuMxvU/
         b05duTgHj6xs0Odm6O6LZIFIj4tAjp31T+mBH7RKtpahLlDqA3yJ1VpXpO1b3ngZnwt6
         8v/KOjYU//zDdt7hxsWOShUiN0bl0YVl2oq+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aMAGuu53qq71mkY/dOmSePxlYMgR7q2jwJRIFacTZR4=;
        b=YYyWXiLLo4mIszyB1PSmHhfFj/IdSB17bEvpOUWAQ+lJpVVPDzL7aHLgYiNxmUqqnE
         rLua3DMHQNj4arvvI8n3/LlKeclFIJMoQnLTgAplLshKvT5Ueil/S9oQXmm38xnKh8lk
         yTuMV/gdIFg9UWZvjwBbzjC8SFskxzjzG5pEvqJpzNJsNU7828cM5STVxyrtbYu4Lvf1
         VPjBCVv6LEtdpNthw7q3dqdAoRD0e/sQ/kUV9cVHiU50yhZGT15M6X11bulX81Z1UrHw
         zygeD2NV+uiHHXuOvnGjgFtjlyw6OjI731qirkBucbbJh228YyaJ7jZJ7Epis6kySyd9
         1U7Q==
X-Gm-Message-State: APjAAAUV9eGRdUeiGa1C4uoy2w1S9oK1IW/7PegQk9PQwNEGxT8iW51g
        5dTBcbccwtPRYSITMj07+yxIF4MS
X-Google-Smtp-Source: APXvYqwfFo9JwMIZ3bQ77MPOxt4Ns64+bY5Qq4p8zaKdoy5I8EHTisW4rFsjt7rfNTa8WaLYx+WBgA==
X-Received: by 2002:aa7:8f2c:: with SMTP id y12mr45725265pfr.38.1564528241582;
        Tue, 30 Jul 2019 16:10:41 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a3sm75205576pje.3.2019.07.30.16.10.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 16:10:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 0/3] Convert some RCU articles to ReST
Date:   Tue, 30 Jul 2019 19:10:27 -0400
Message-Id: <20190730231030.27510-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This patch is a respin of the RCU ReST patch from Mauro [1].

I updated his changelog, and made some fixes.

[1] https://www.spinics.net/lists/rcu/msg00750.html

Joel Fernandes (Google) (2):
docs: rcu: Correct links referring to titles
docs: rcu: Increase toctree to 3

Mauro Carvalho Chehab (1):
docs: rcu: convert some articles from html to ReST

.../Data-Structures/Data-Structures.html      | 1391 -------
.../Data-Structures/Data-Structures.rst       | 1163 ++++++
.../Expedited-Grace-Periods.html              |  668 ----
.../Expedited-Grace-Periods.rst               |  521 +++
.../Memory-Ordering/Tree-RCU-Diagram.html     |    9 -
.../Tree-RCU-Memory-Ordering.html             |  704 ----
.../Tree-RCU-Memory-Ordering.rst              |  624 +++
.../RCU/Design/Requirements/Requirements.html | 3330 -----------------
.../RCU/Design/Requirements/Requirements.rst  | 2650 +++++++++++++
Documentation/RCU/index.rst                   |    7 +-
Documentation/RCU/whatisRCU.txt               |    4 +-
11 files changed, 4966 insertions(+), 6105 deletions(-)
delete mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.html
create mode 100644 Documentation/RCU/Design/Data-Structures/Data-Structures.rst
delete mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
create mode 100644 Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Diagram.html
delete mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
create mode 100644 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
delete mode 100644 Documentation/RCU/Design/Requirements/Requirements.html
create mode 100644 Documentation/RCU/Design/Requirements/Requirements.rst

--
2.22.0.709.g102302147b-goog

