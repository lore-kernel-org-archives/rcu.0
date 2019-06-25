Return-Path: <SRS0=oVcv=UY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB5C48BD7
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E1E2085A
	for <rcu@archiver.kernel.org>; Tue, 25 Jun 2019 06:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWCaet82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfFYG0c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:26:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44958 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfFYG0c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Jun 2019 02:26:32 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so16057997otl.11
        for <rcu@vger.kernel.org>; Mon, 24 Jun 2019 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNhfYga4AhwQjbAAWyfLpNxxz+0VRsRKPxwJfio3Wn4=;
        b=JWCaet82q7wI60bo6TvbcQTCyeABleZz2YiXwz1Iz80LaJDSAvD1Z/dY3/+ANjZe0C
         plXwSYcmgQ5EXXjT1ZU8ArLKXWl3exapQ99zpxqTh2pFkniY+PDDXaXlhdaPDVN5Iody
         fnUROVkcSCujUq3P+6oDBoj9W/u4saV+M3In7RMLsLzsbUAfbNKsQAVNpPGGNZvewlQn
         e9FMzaRgKy22202DTEGAMQf1e1J4hxsfewGpZt+i4N/uxPEQqNyiz0HxDCTtUSajoEcB
         WfObHARHbWYjIqjOCKGi+n791rnXlOxE/rsiMK3vyyJdkg5aoKWVt0HhuPyRlXE1J800
         oysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNhfYga4AhwQjbAAWyfLpNxxz+0VRsRKPxwJfio3Wn4=;
        b=LbI4Y12vUs+oxCwnrr2uPvzn2vPyHQH5TwpXVJVxGAhG/a2mdM7vKWLWznoYUtW0Q7
         idlWmyoqrwcizSaCMuWq91OoxGSlHNPDqdfJ75fr1lKVSsKwmc9Wfx3nBlvEJSh5SWTH
         cs/I4stJEg/rMVAvALyk7qQVmBmnuBJzYyFOT4JY05kvzc41cEjAb8h56o9W59mNA6GV
         iGp9aCSoa8TyZBkz6QB/euLsRo/4WLmVw6zOMiGlvzRUKdL2RaY/8XIIVK/2XZ0s+Haw
         p04YvytnNwPJHm/z1FKt2a2NSBVPboieEN0SigGX8fOI2XmtoX/EH3odmWOPm5fokYwz
         /PTQ==
X-Gm-Message-State: APjAAAUZ3kv3/xyq4pjB+B3nSoQtI/izBfbq3E8tkuEzdQkCRxvMd27H
        w3C3zGjinU+gp/zRAyn3CRI=
X-Google-Smtp-Source: APXvYqzdv5n4DmMtx4cxwTJfXCUiyjtHjyeVpxtUfJ18JoISB+SD6Lacl1Fy4anLAbrFqLHF5p/wGA==
X-Received: by 2002:a9d:7245:: with SMTP id a5mr20876285otk.232.1561443991769;
        Mon, 24 Jun 2019 23:26:31 -0700 (PDT)
Received: from rYz3n.attlocal.net ([2600:1700:210:3790::48])
        by smtp.googlemail.com with ESMTPSA id e4sm5050183oti.64.2019.06.24.23.26.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 23:26:31 -0700 (PDT)
From:   Jiunn Chang <c0d1n61at3@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, paulmck@linux.ibm.com, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org, corbet@lwn.net
Subject: [Linux-kernel-mentees][PATCH v3 4/6] Documentation: RCU: Rename txt files to rst
Date:   Tue, 25 Jun 2019 01:26:25 -0500
Message-Id: <20190625062627.26378-5-c0d1n61at3@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190623081413.7095-1-c0d1n61at3@gmail.com>
References: <20190623081413.7095-1-c0d1n61at3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Rename the following files to reST:
  - rcu.txt
  - listRCU.txt
  - UP.txt

Signed-off-by: Jiunn Chang <c0d1n61at3@gmail.com>
---
 Documentation/RCU/{listRCU.txt => list_rcu.rst} | 0
 Documentation/RCU/{rcu.txt => rcu.rst}          | 0
 Documentation/RCU/{UP.txt => up_rcu.rst}        | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/RCU/{listRCU.txt => list_rcu.rst} (100%)
 rename Documentation/RCU/{rcu.txt => rcu.rst} (100%)
 rename Documentation/RCU/{UP.txt => up_rcu.rst} (100%)

diff --git a/Documentation/RCU/listRCU.txt b/Documentation/RCU/list_rcu.rst
similarity index 100%
rename from Documentation/RCU/listRCU.txt
rename to Documentation/RCU/list_rcu.rst
diff --git a/Documentation/RCU/rcu.txt b/Documentation/RCU/rcu.rst
similarity index 100%
rename from Documentation/RCU/rcu.txt
rename to Documentation/RCU/rcu.rst
diff --git a/Documentation/RCU/UP.txt b/Documentation/RCU/up_rcu.rst
similarity index 100%
rename from Documentation/RCU/UP.txt
rename to Documentation/RCU/up_rcu.rst
-- 
2.22.0

