Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BF2C4321E
	for <rcu@archiver.kernel.org>; Wed, 30 Nov 2022 19:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiK3TKK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 30 Nov 2022 14:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3TKJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 30 Nov 2022 14:10:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC475445A
        for <rcu@vger.kernel.org>; Wed, 30 Nov 2022 11:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669835352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QVNS4KGKiQlkWq9pmeMaxREOPvT9GqK+wYyEoJX7MI=;
        b=fNAztgTguVuNSrC9xuzn/Lfq7O64cfU2uESPPb+GlBtrog+4udObjb0/BjgJ4oSPZGR2Sb
        0xzQGCh7lvLq/UlWEi2KibKUa3iJjJau7Poxwq/Lr02az3liAkuukivOkwY8/pREzp6A6H
        S/eQIgwsfqC5mJjdqSeQqSNmBvL+FWk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-539-bh4-bCdXMWOFNg7UvKspPg-1; Wed, 30 Nov 2022 14:09:09 -0500
X-MC-Unique: bh4-bCdXMWOFNg7UvKspPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92AD31C0896A;
        Wed, 30 Nov 2022 19:09:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 043FF1121314;
        Wed, 30 Nov 2022 19:09:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAEXW_YS1nfsV_ohXDaB1i2em=+0KP1DofktS24oGFa4wPAbiiw@mail.gmail.com>
References: <CAEXW_YS1nfsV_ohXDaB1i2em=+0KP1DofktS24oGFa4wPAbiiw@mail.gmail.com> <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1> <20221130181325.1012760-14-paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     dhowells@redhat.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Marc Dionne <marc.dionne@auristor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH rcu 14/16] rxrpc: Use call_rcu_hurry() instead of call_rcu()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <639432.1669835344.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 30 Nov 2022 19:09:04 +0000
Message-ID: <639433.1669835344@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Note that this conflicts with my patch:

	rxrpc: Don't hold a ref for connection workqueue
	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/com=
mit/?h=3Drxrpc-next&id=3D450b00011290660127c2d76f5c5ed264126eb229

which should render it unnecessary.  It's a little ahead of yours in the
net-next queue, if that means anything.

David

