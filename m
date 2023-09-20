Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EA2CE79CF
	for <rcu@archiver.kernel.org>; Wed, 20 Sep 2023 13:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjITNAG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Sep 2023 09:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjITNAD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Sep 2023 09:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A162C135
        for <rcu@vger.kernel.org>; Wed, 20 Sep 2023 05:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695214740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IB5ZIQc2cKPD403czWBLbEjCZuGs9WsxBdWgpieqM34=;
        b=N8fn8PKe+zyp6BBJFVgQ2M5zlNjtRhXEnvpb2Nvi04+CyI6a6n5zwb1mZvmtR8mEPX180E
        O2wznRrUwBXOivycEVFOAOtQJT11sMRPrGWfimk7ok+/NboWQUuhXC3G056dVLBWRgjy9s
        NstaH7XhfOyAAxXgg0DnWzn8Nvgywyw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-NEoQVg0hOZaq9D3I6v-zUQ-1; Wed, 20 Sep 2023 08:58:59 -0400
X-MC-Unique: NEoQVg0hOZaq9D3I6v-zUQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a9cd336c9cso155349166b.1
        for <rcu@vger.kernel.org>; Wed, 20 Sep 2023 05:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214738; x=1695819538;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IB5ZIQc2cKPD403czWBLbEjCZuGs9WsxBdWgpieqM34=;
        b=bTYGPvYNPZZ7hPwZwgbgcacXxcUHE5iqcwgb4mKO8MQSedRAbu8wkDdarqEWV015yz
         7UHagKs+ZLq8GWv1LniEUKFbsbAWh2GAz67WsJc16OAQ8Evay7Xd+f2A2xc1hqJcvr5Z
         G292DCXKoFKGnjkgzvV9sS84t6YIOJX2PF5didkmO1cv5XVskYJzZhoVO4utjlyej9xd
         NEDkx2MUehI7eKoBVawiAWc3KP9k+SHjSGxVThfHD16OwwB2EtLlklODOajlwk9t3XeR
         CQGryFRlhKsNHOBCE+TRr6SCE1Is63IqpoOI1pK991wYLtmtAhiqYfjyrLrZK34Tq7ch
         eiIQ==
X-Gm-Message-State: AOJu0YzRhPMG/vAg4UStbWCQJkNSDNoFFQU5zdMLckZX1gyCL/4eEHhW
        3/yq5gJK7s2Fhu7oivZqm4tp5wetopOHEzulHZZ8QzFEqG4+K4SPDoaTJnS+aD0toeZjLKw06Fm
        WnAj4LSyP7B62PG2JxGbRBNM=
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr1475143ejc.6.1695214737873;
        Wed, 20 Sep 2023 05:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyqwNmbkZEDyjkcZHdkDeRwAw5EgPqm5zJnPl6/XMznfBnmEs30U+2P1hzBTCGlfRYX4ZcYQ==
X-Received: by 2002:a17:907:9512:b0:9ae:4492:df34 with SMTP id ew18-20020a170907951200b009ae4492df34mr1475125ejc.6.1695214737455;
        Wed, 20 Sep 2023 05:58:57 -0700 (PDT)
Received: from ?IPv6:2a01:599:906:7772:a505:d891:dcff:9565? ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id rn5-20020a170906d92500b0099bd5d28dc4sm9283591ejb.195.2023.09.20.05.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:58:56 -0700 (PDT)
Message-ID: <79e83b07045c35527f0b91fa5ba36d9c501cd8af.camel@redhat.com>
Subject: Re: [PATCH] rculist.h: docu: fix wrong function name
From:   Philipp Stanner <pstanner@redhat.com>
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 20 Sep 2023 14:58:55 +0200
In-Reply-To: <db6bc865-199d-4784-a509-5b0c80c0501c@paulmck-laptop>
References: <20230919194754.20574-2-pstanner@redhat.com>
         <db6bc865-199d-4784-a509-5b0c80c0501c@paulmck-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 2023-09-20 at 03:53 -0700, Paul E. McKenney wrote:
> On Tue, Sep 19, 2023 at 09:47:55PM +0200, Philipp Stanner wrote:
> > The header contains a comment that details why the functions
> > list_empty_rcu() and list_first_entry_rcu() don't exist. It
> > explains
> > that they don't exist because standard list_empty() can be used
> > just as
> > well, but one can not expect sane results from a subsequent, quote,
> > "list_first_entry_rcu()".
> >=20
> > This function (obviously) does not exist. What the comment's author
> > actually meant was the standard list-function list_first_entry().
> >=20
> > Change the function name in that comment from
> > list_first_entry_rcu() to
> > list_first_entry().
> >=20
> > Additionally, add the parenthesis to list_first_or_null_rcu to be
> > congruent
> > with that entire comment's style.
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > Hi!
> > I hope this helps.
> > I wasn't 100.000000% sure if that's correct, but I thought asking
> > is for
> > free 8-)
> >=20
> > Regards,
> > P.
>=20
> Thank you for sending this!=C2=A0 Please see below.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Thanx, Paul
>=20
> > ---
> > =C2=A0include/linux/rculist.h | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > index d29740be4833..4837d8892691 100644
> > --- a/include/linux/rculist.h
> > +++ b/include/linux/rculist.h
> > @@ -331,9 +331,9 @@ static inline void
> > list_splice_tail_init_rcu(struct list_head *list,
> > =C2=A0 * rcu_dereference() is not needed), which means that list_empty(=
)
> > can be
> > =C2=A0 * used anywhere you would want to use list_empty_rcu().=C2=A0 Ju=
st
> > don't
> > =C2=A0 * expect anything useful to happen if you do a subsequent
> > lockless
> > - * call to list_first_entry_rcu()!!!
> > + * call to list_first_entry()!!!
>=20
> You are quite correct that the original is incorrect, given that it
> does
> not exist, but a better change would be to list_entry_rcu().

Hm, are you sure that's what we want there?
list_entry_rcu() does not take care of actually getting the list_head
to begin with. The caller would have to provide it. The question is how
would he do that? The goal in the purposefully broken example's code
is: Get this list's first entry, if it exists.

Do we agree that the example as is is maybe a bit out of place in the
first place, because it could always cause in a fault when the list got
empty since the check, thus, resulting in us trying to dereference the
list-head?
If that's the case, maybe we should also change the wording "don't
expect anything useful to happen" to something like "don't expect
anything useful to happen (i.e., your code could fault)".
"Not useful" doesn't sound like "can crash", that's my point.


I suppose a working broken example might be:

if (!list_empty(mylist)) {
	first_head =3D READ_ONCE(mylist->next);
	first_member =3D list_entry_rcu(first_head, ...) // <- could fault!
}

?

>  The reason
> being that list_first_entry() does not have READ_ONCE(), allowing the
> compiler to play all sorts of games (see
> https://lwn.net/Articles/793253

Yup, I know that article.
I'm frequently astonished how difficult the situation has become. I was
at times wondering if things were better were C (or a hypothetical
successor language) designed to take parallelism into account in the
language's core.


> for some examples).
>=20
> > =C2=A0 *
> > - * See list_first_or_null_rcu for an alternative.
> > + * See list_first_or_null_rcu() for an alternative.
>=20
> Good catch!
>=20
> Please do feel free to send an update.

Sure, will do once we agreed on the best wording :)

P.

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Thanx, Paul
>=20
> > =C2=A0 */
> > =C2=A0
> > =C2=A0/**
> > --=20
> > 2.41.0
> >=20
>=20

