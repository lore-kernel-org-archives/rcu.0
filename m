Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628DCC433ED
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 00:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198296135F
	for <rcu@archiver.kernel.org>; Tue, 20 Apr 2021 00:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhDTACG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Apr 2021 20:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhDTACG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Apr 2021 20:02:06 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA53FC06174A;
        Mon, 19 Apr 2021 17:01:35 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id j3so17798513qvs.1;
        Mon, 19 Apr 2021 17:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCsvR8ed7Ced6QtfotFXE2oWXUOCJco3BBQfcsvrgLs=;
        b=rEvQ3g81yMTfKkZquowAjEOOmoQgzWEJ/Lr00Y1XDZoHZYcAPwQsSS4xtMj+N9L4s+
         F+0tgKsL4iTPDj6cXX5VTiwZegk3eQnqH79G/2i/3DmIUJ/uYnxG8uwIfq6bu1s8xIbM
         QGl+6hV32570u1oEWFhqW32djMvQFzq+uX8dIpBCgwgEd03g2OEFUDPKGUOPlyoD2NIe
         M4ZwGX6d9Vmmwt4f/soST0K9gfYSWyA0ZAX7pa+7VvdO7Eq73arCnm82nzsJOfbcSWTw
         UuiVpJgW9iZQ8iXoalOEpJC7zZ9j5JdK3xBmrAthxhwHwwlXOoKoG6/gDR7DuJ3xEHYL
         SMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCsvR8ed7Ced6QtfotFXE2oWXUOCJco3BBQfcsvrgLs=;
        b=Pi/lcd8xcn620GF2V7aqZ9Sjb9YJ9ED+t5vf277Nda/6bx4sBbusOHixq4pqthzi7v
         fQ7FmfmJ7ZOZ/ehNI24rpPP/rntTwRYzDlf49UC//Y9XNNTJOb0E3ESC5Ut3NfK/zIDp
         AoOa7sMe3XWCBCWaPZ7w0Gy6IUGyjbWKmE6Fxn7HFquzOsf4o/Qwzj2/eLtW9GvvEPvo
         cfhATHjG0g4BK5ST4i8YKs3P4SH8E4YIbhv0iA61u8kt+szhCY+w0+6QqbswFQYWxkra
         q6vhPfam31rkgS4/C+N5gA+JR4XuZYxEBEFSgDvZ+NmwZzsKlMrLCT1vag7JQx2SzbYX
         ksOQ==
X-Gm-Message-State: AOAM532a4Zcj7k+avcY2JqfJ0611KZ6XuMbTyLDAsYJTudInorAXQERX
        vaeVN3VNNLEL3rVd5K6hojMupgJpTHw=
X-Google-Smtp-Source: ABdhPJxuIH+fhGRayqCDTr9el+KOvpGwN79zRS8qZxelpgUMNF1e3e/0zmpI1iyYs19IU/xmHrN+2Q==
X-Received: by 2002:a0c:db05:: with SMTP id d5mr23857323qvk.41.1618876894388;
        Mon, 19 Apr 2021 17:01:34 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id o12sm10497099qtg.14.2021.04.19.17.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 17:01:34 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 0/2] bitmap_parselist: support 'all' semantics
Date:   Mon, 19 Apr 2021 17:01:29 -0700
Message-Id: <20210420000131.21038-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

RCU code supports a special group 'all' which selects all bits in a bitmap.
We have recently added 'N' extension for bitmap parse, so that '0-N' would
have exactly the same meaning as 'all'. But because the 'all' is already
used by RCU, it would be reasonable to support it in core bitmap code as a
common and easy-readable alias for '0-N'.

Moving the 'all' support to core bitmap code adds another level of
flexibility for system configuration by supporting patterns. For example,
every second bit in cpumask may be selected like this:
	isolcpus=all:1/2


Yury Norov (2):
  bitmap_parse: support 'all' semantics
  rcu/tree_plugin: don't handle the case of 'all' CPU range

 Documentation/admin-guide/kernel-parameters.rst | 5 +++++
 kernel/rcu/tree_plugin.h                        | 9 +++------
 lib/bitmap.c                                    | 9 +++++++++
 lib/test_bitmap.c                               | 8 +++++++-
 4 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.25.1

