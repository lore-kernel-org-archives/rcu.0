Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAECEC77B7F
	for <rcu@archiver.kernel.org>; Fri,  5 May 2023 14:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjEEOf4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 5 May 2023 10:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjEEOfz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 5 May 2023 10:35:55 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3D3150FD
        for <rcu@vger.kernel.org>; Fri,  5 May 2023 07:35:51 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-61b6101a1b9so8050896d6.3
        for <rcu@vger.kernel.org>; Fri, 05 May 2023 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683297351; x=1685889351;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1ke4TbuRdOf5IM10kJu2GT3dAkCudOmMEKNHG0MQH0=;
        b=C5F9B+Odr/yooITjToObv9Z7pERPEZiQaRqO4oOga5SqMp0U1bcWjSH4QnIwPGh/D5
         qCWJR92URhJgUOVwKJ6d/pupONq2JfpnPioFKWOy074AQdtI/KaJ3Ft5BEvr0ckeLHjQ
         0Z4+I2GQPy5hmrRwONK91y/pTS7NQKc87g7Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683297351; x=1685889351;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1ke4TbuRdOf5IM10kJu2GT3dAkCudOmMEKNHG0MQH0=;
        b=IzvsQBwRphIA89uiQnKzbynBlXe7qGlLZjby/ITLNe3SjhG/weuATCfa/2bfGO6QYO
         YmR7jbcJERWT7LbzYl+7CxqSNAx81wtUfw6zvdn37X3Q6xmC5zw1VEdjswA9hMocegIQ
         yZZgHyOiwcw1tmMpkFvEMYH3uXzN3BUM2ln4ByJz7mq13bdUtp/zRAfokoazuOd+lJD+
         ZTRIara1IgB0UEhzvvykZjrNuCr1P6FyOkBry3+aClTytnKrWz/54cW9soH2VDEj/sBd
         41hOQOLno6GpHIHzVgZsXt998OZmM8vaqss4HU0HkjEUIbhUR7iBd1/uMCXVUVvy+Jn5
         9DrQ==
X-Gm-Message-State: AC+VfDzaflnmKAQQw6ZJfWQ4U96u0z4/57444dy8egtV6TwyJQ9aJI0+
        Uoas9BRPlER8hscYVw96Gyu5EQ==
X-Google-Smtp-Source: ACHHUZ7tS/Y0/qudpQiaWxcIlraZVBYmyIew/CSyMOspZlFlYBltLoG1QQMqCbFvl3nZ5ccR1mYRyw==
X-Received: by 2002:a05:6214:3008:b0:61b:6cf2:eaf1 with SMTP id ke8-20020a056214300800b0061b6cf2eaf1mr1895447qvb.22.1683297350962;
        Fri, 05 May 2023 07:35:50 -0700 (PDT)
Received: from smtpclient.apple (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id y16-20020a0ca910000000b005ef6557834fsm630052qva.62.2023.05.05.07.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 07:35:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 3/4] rculist.h: Fix parentheses around macro pointer parameter use
Date:   Fri, 5 May 2023 10:35:39 -0400
Message-Id: <D4B84962-D9A0-4405-BD07-22E9E2ACA243@joelfernandes.org>
References: <20230505100621.5d468f95@gandalf.local.home>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>, rcu@vger.kernel.org
In-Reply-To: <20230505100621.5d468f95@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On May 5, 2023, at 10:06 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> =EF=BB=BFOn Thu, 4 May 2023 12:19:38 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
>=20
>>>  void f(void)
>>>  {
>>>          struct test *t1;
>>>          struct test **t2 =3D &t1;
>>>=20
>>>          list_for_each_entry_rcu((*t2), &testlist, node) {       /* work=
s */
>>>                  //...
>>>          }
>>>          list_for_each_entry_rcu(*t2, &testlist, node) { /* broken */
>>>                  //...
>>>          } =20
>>=20
>> Yeah it is not clear why anyone would ever want to use it like this.
>> Why don't they just pass t1 to list_for_each_entry_rcu() ? I would
>> rather it break them and they re-think their code ;).
>=20
> Remember interfaces should not be enforcing policy unless it's key to the
> way the interface works.

Oh yeah, 100% agree. I am not particularly against this particular patch but=
 I also dont see it as solving any problem. Feel free to Ack the patch if yo=
u feel strongly about wanting it.

 - Joel


>=20
> -- Steve
