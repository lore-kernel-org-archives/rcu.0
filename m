Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F33C433F5
	for <rcu@archiver.kernel.org>; Wed, 10 Nov 2021 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FF0611F2
	for <rcu@archiver.kernel.org>; Wed, 10 Nov 2021 14:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhKJOlm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:41:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232035AbhKJOlm (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 10 Nov 2021 09:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636555134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E2r2UR3h929x6RcaYO1V3yxJtIaHTa00azzlSm0m4Ro=;
        b=jMgjn1Li21bnhlQRYtPSTQ0d1AdmvSQS+yJvFRPwFXyq0JTPPZUmaAWoTTUqIaf52weclS
        6hsGNDGpHbIXpn6ImQqrLH9hqkehONkl0MphVniPH9wWCkQvHoQUBTcHF7hmQ7U8Jfn7IF
        VKVPC4vFfb62W2Pqt06dH5VQ84ylN14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-p5p9y7XoNjaDRT3jRT4ZBA-1; Wed, 10 Nov 2021 09:38:51 -0500
X-MC-Unique: p5p9y7XoNjaDRT3jRT4ZBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 882AECC639;
        Wed, 10 Nov 2021 14:38:49 +0000 (UTC)
Received: from wcosta.com (ovpn-116-123.gru2.redhat.com [10.97.116.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1486160CA0;
        Wed, 10 Nov 2021 14:38:13 +0000 (UTC)
From:   Wander Lairson Costa <wander@redhat.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org (open list:TORTURE-TEST MODULES),
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU))
Cc:     Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH v3 0/1] rcutorture: Avoid soft lockup during cpu stall
Date:   Wed, 10 Nov 2021 11:37:44 -0300
Message-Id: <20211110143745.468361-1-wander@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This version fixes the include in the beggining of the source file.

The patch applies cleanly to 

git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git

Wander Lairson Costa (1):
  rcutorture: Avoid soft lockup during cpu stall

 kernel/rcu/rcutorture.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.27.0

