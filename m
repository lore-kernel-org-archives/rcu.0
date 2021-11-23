Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB648C433F5
	for <rcu@archiver.kernel.org>; Tue, 23 Nov 2021 00:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhKWAkX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhKWAkW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Nov 2021 19:40:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93D2D60698;
        Tue, 23 Nov 2021 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637627835;
        bh=N9Z7TNvshj0BkfSYkih2cHP40EkWEtFVjH93cnUbBcs=;
        h=From:To:Cc:Subject:Date:From;
        b=PQVxqav/hMGnmVZyc83AW/rZctXJ2cTD1KIJ/0HAKFuwZ3E+ypgMr4ape3dv/xN4u
         v51GF2b3rUa0p0Q/8QxcceXz/jpYgUidydJ/ha74ALGLXqFKQFKpgatgdQvmSmwd8I
         TFkDNulyvxAarZgQBDcs+LjJ/zPWYqWcg5TYxNu5ILLeyMNG5tZ+IkvwBgWv2GALPe
         xt3GzfAYXqqZ+7pcYTeuFyEn2HTrHxNRqfr4zEX/ALumEgx/5NfX5zPs7B9qRWSJLZ
         JpSLqzBxehntvP7uvODgdPwKHtQTXPmkGtOXqHEl22DdpDL1cgQ99Ln/J5EuRyJ4ge
         32AszOVW+Zv2w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 0/6] rcu/nocb: Last prep work before cpuset interface v2
Date:   Tue, 23 Nov 2021 01:37:02 +0100
Message-Id: <20211123003708.468409-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Changes since v1 after Paul's reviews:

* Clarify why the DEL vs ADD possible race on rdp group list is ok [1/6]
* Update kernel parameters documentation [5/6]
* Only create rcuo[sp] kthreads for CPUs that have ever come online [4/6]
* Consider nohz_full= on changelogs

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	rcu/nocb

HEAD: da51363e5ddf54d6ce9c2cfbab946f8914519290

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      rcu/nocb: Remove rdp from nocb list when de-offloaded
      rcu/nocb: Prepare nocb_cb_wait() to start with a non-offloaded rdp
      rcu/nocb: Optimize kthreads and rdp initialization
      rcu/nocb: Create kthreads on all CPUs if "rcu_nocb=" or "nohz_full=" are passed
      rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
      rcu/nocb: Merge rcu_spawn_cpu_nocb_kthread() and rcu_spawn_one_nocb_kthread()


 Documentation/admin-guide/kernel-parameters.txt |  28 ++++--
 kernel/rcu/tree.h                               |   7 +-
 kernel/rcu/tree_nocb.h                          | 119 +++++++++++++++---------
 3 files changed, 96 insertions(+), 58 deletions(-)
