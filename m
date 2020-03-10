Return-Path: <SRS0=CUdJ=43=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2B0C10DCE
	for <rcu@archiver.kernel.org>; Tue, 10 Mar 2020 20:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8BA21655
	for <rcu@archiver.kernel.org>; Tue, 10 Mar 2020 20:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOdveti6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCJUto (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:49:44 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40495 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJUto (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 Mar 2020 16:49:44 -0400
Received: by mail-ot1-f54.google.com with SMTP id h17so2162209otn.7
        for <rcu@vger.kernel.org>; Tue, 10 Mar 2020 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mcvoPnKuCsxqZQen7vOamaSC8ZicKtkdOaJ+hpqk9w8=;
        b=dOdveti63p3xbOHMq9QXHLYLpVP+lPBtzUW0hAZtWiGIKF1wzfzmJqiEdkdHBI/aKf
         RursCZeTfJz0hjNQd4QlNrMYlgjUMYM31/q9wZG4qJOksZWvPG+QeAgo1znTWqNxvdJl
         4lsKTml2GQrNKtTfehS23VBcdduYXd2R8x6ZZRcz9m5s6iPj7HssZtB7uZKlUPHz+74d
         uZ3Adbb0i+cZsXLaFKza/j8wjc1a7nPSjt6P7nh+b0GHCOdXCC1WV/qdTI1miMDD2+uA
         JmyzXVA3tgH3wI1sAX8+w+T387lA4CG9WDbMmIz97HGtN7QHjXAXjuKQ9AA608UzmeqU
         GSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mcvoPnKuCsxqZQen7vOamaSC8ZicKtkdOaJ+hpqk9w8=;
        b=H9/CGlBSQKf1lgT4nOYNOUwC+aYXJ0SIDZbJ5XTohcO9kbbEl5ccqUjJmUgVrNf5Qk
         oKOZ55h6DqVExk/c/G644yroz4T8FRIt1AC/FN43a1qdOwhfjN9EmGm1yfs9Nt+/S3aS
         JLxw1/RO6+w7n4Q8yDDwTY2aYRsSXGJ60b8hegnuXPxl0KWXEjpdQhyLuBRLidiAEaaP
         Ppzg7bB6aA7wEvxME7u3vhTHcFx/fcHWgKdJSA5/X5dwcF49X1MUXLMOvJL9kP6YfTlD
         9jOxvtt66fELLb5xJXOpfksMcyvhZCA/r9FUnYxhoRngg0K+IGSfXtfJs/qhLSAE8UlB
         lW2w==
X-Gm-Message-State: ANhLgQ1cJeHV82Fna4PFvTpyxo1FChwiwpaiOfAk2gUHZIIBUgK8btMH
        ohdy104lQW7rOLtXR329e2zf9H3yQF4=
X-Google-Smtp-Source: ADFU+vvKe1GQgPAhxCuSvAA2AbAGPKitADOCgop6eSzmKb6YKfztImZobGFOMWK3BKAOq/oyQqOtsQ==
X-Received: by 2002:a05:6830:18ce:: with SMTP id v14mr19190222ote.4.1583873383342;
        Tue, 10 Mar 2020 13:49:43 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 10sm4612203oip.2.2020.03.10.13.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Mar 2020 13:49:42 -0700 (PDT)
Date:   Tue, 10 Mar 2020 13:49:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Clang warning in kernel/rcu/tasks.h
Message-ID: <20200310204941.GA53917@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,

It appears that the commits 37564025a3d7 ("rcu-tasks: Refactor RCU-tasks
to allow variants to be added") and cbd703932774 ("rcu-tasks: Add an
RCU-tasks rude variant") both add a forward declaration to rcu_tasks and
the rcu_tasks_gp_func_t typedef, resulting in the following clang
warning:

In file included from kernel/rcu/update.c:563:
kernel/rcu/tasks.h:24:16: warning: redefinition of typedef 'rcu_tasks_gp_func_t' is a C11 feature [-Wtypedef-redefinition]
typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
               ^
kernel/rcu/tasks.h:17:16: note: previous definition is here
typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
               ^
1 warning generated.

Maybe a rebase or merge gone wrong? Would you mind taking a look and
fixing it up if possible?

Cheers,
Nathan
