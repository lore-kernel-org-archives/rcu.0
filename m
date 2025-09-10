Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70C30B53E;
	Wed, 10 Sep 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495592; cv=none; b=Un4HyjLjpdytETspe2lsCwsaUId7vmAAA3Kpl9lnzQcaEsFmxnHewDn6vrfWxvF+VoJzcSMOMaVBy+LI4eLOqqtynAoqIBP4XYXC48HViZbs5p20xfwC/bpGXXUXbUii9mpiSP8oeJoHP1JUuYqalfr3jcnUykTzqD18O3P+pa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495592; c=relaxed/simple;
	bh=TnoBoSCeTWlfNEZUxvuV65VzDrOEuWLvpjbY5EN+OcY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RmeMhyPZa8AisbJuvmxcCBKaI9gUxwj9aRgFKxhHfcJIycp92MrJ4l546vRRGkmLDnk/feR7oqmUUmjULpX3WTEsrIv7vhlBIpwSjkJmxi2aRdoHAcGvQsM0V9PQWQIXdpQJEYCIenqtyTDm2HUzN7gIzDx/7WWezq862loHM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=soc1oYpA; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="soc1oYpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1757495588; x=1758100388; i=markus.elfring@web.de;
	bh=TnoBoSCeTWlfNEZUxvuV65VzDrOEuWLvpjbY5EN+OcY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=soc1oYpAM1uHxTbOhs1QkWuQ8Ew86W/IsVADoU7sJWrPxgilhwatDqvJpUIDzAVO
	 ROMeNwI67uFiXog+G3tXVjWCjyJw6foj72qoLjJudQMYjR8A8IkeuDKY4OKu8zmSy
	 S6JNXgzRxL0D6Ej/Pe61gvoJ/RteMb9H7+xVklewPgBo2JDm1YFo6EOjBcaUT5Mud
	 qdcdrAhGyuuzta/1IyL+R1b/OwKTRZLLKfiJW0P6za6KCyVivGx8pXZoB8kcCchAl
	 TAHJwOwp3/Od1vrcAubyNU5d6u7U9M3EYWPA3PdF5nkjQZBQlFDcs5duIuw0/sDdF
	 SDmdJnVws9c7Ixry4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.214]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3uS-1uUKZT0jn8-00epId; Wed, 10
 Sep 2025 11:07:25 +0200
Message-ID: <b062b061-912e-4fee-933c-5feea67b4c62@web.de>
Date: Wed, 10 Sep 2025 11:07:10 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, rcu@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20250910083630.3735022-1-kaushlendra.kumar@intel.com>
Subject: Re: [PATCH] rcu/rcutorture: Improve error handling in
 rcu_torture_fwd_prog_init()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250910083630.3735022-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+VKctSA5pd6HpM/MeEKTwibfCrMXhlVuUJnkRE3HJ/8gnvJ379O
 qrsPr2MP9vMWU+3KhCsWT7X0VO8Jhuru7nZXIzCJS6Live6LY/Uho7PiBubQf/JhoScIyJ+
 XxWIQUw30gqu7Qitd986WyjLb2DLH9Ab0W0T5zKWIW0EoosoZA3gBGGEzop96RCOiOOdGXQ
 GYTJ4YslQaazSewo4jLlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zOIGBMQm4eA=;LDrNul5DT1m67imTykSRvm32gC5
 NbnIKOlHlE4ukdR8UD+I+ESuSfW/iq0vIeefkhOkBRnhY+5xNfml43zNNQLJ6X4Rz5pP3QJ5Y
 0QrefQaOckrGs2LfrM5fhJ6G65Vnb/9LmQ5LzGAqPs3j9i6BZnCMYLCoPErGdBMZaamGAEIRC
 ucP7MN8w5BjP0R7ExanjeELvnH0o3sfgfr2/Zf4QUd2GAFwxTUH/OerBxWdk72L4/yE/TMV8p
 IoK1Piq1iaFtXC4kYOW1EBMECTu7smCYjTpSLEifxsfphbt2AV5XEkFXR6ynhbuZlJWyg0AJ/
 PuiJXs63TSfxm0gKzMIjnnqyLEQnGm1O5cjQkmDrvvh6/d6NP3To+vtQDm3O3T/gXWQLDAEqi
 Fy4GqLYz8sHW1Mz8Nm+WjfSVe3NCsBkQvZJgaTrUhbkIQax8l9WROv728+bjaRnyE0rAk8sMf
 SG+tWuy5Ut7kGnICS9419ZmtXWxO/jIQHuDJ74AWgMZauZHyF750Kf67L+W2c40xngH5p8Jw2
 ma7JCg2GDcqFviWE1qs7eWFS//+zGK6tlyqEGaihUAURbLkjzvpZPc96FQTJ5lqx3iLcMf02+
 az43svG0wSwxsAJABqMPr76bD24aCWbuSrv3WZAMbcOMtg5KvQsWKkSN25BV6RxJuuEw96Wln
 FzLs0+k7RAGZy+GWiIYacvoCPDblhaKg9i1J7vgBe2flS7rWq4bbRbAswbjWOx76Oy+/Ae2te
 yw6zhqjJS55ete+PLQTUOVgA/reGIw1ID+0+EIzTCaZIuHxL24aijwRFANihNF0ppbDGbNoSw
 M3jeNtZgdSTY+DYJnHBejnYh5p61idmfO/IFaoIZ2X/rQ23gPHvXtfLLnyOqfiY4R2uQOsFYh
 LL/RQocCnCr8aEUjYuclCz0rOPaBz4xBQi2e/vL769fdTmPmnRSbzvW6HzJ+MBegEZWpzm94L
 +G7cVm6rLLKMIpUzw4O4zYIkunHADyQqE9a71jPLIUtMKsVWNtEh5XxsPtYH2gfGs6qMH628q
 QqhFuVspFIWGfXfcARalDXaGG+fDVVpsxNSktB9gXLvDpbFj64Jp86Wrfsr8f3d4DvMBkyNut
 8mjp2U0nhULHrnVzqjNaZw53mLGhCGm5fi4VuMoYZUoRsPObOM0EQXnAXnpeKHiQW/LCccfri
 zXohZz6QWgzkM6tJAEwcHiEtMsKP/UPWuwnxEPByCmLP4Hrh0DX0QfYwGmoNIjQcanfWjKKgO
 EKVpB+Cp69nntIc7YK5xFZDIWQbC89pIIijIHoPnsP5iTokoza3WoH1V+hqVjz6vx6fQ6Ta+S
 qQYgI90Rl0kl9u/JUffAKqSK+ByHK7Dzk5j4mATj/yRxdEdQvp1z9xONA9f8K0jB1Hg1TdCt/
 iHj+Qg0U7004CaHZOfExDNBloBf6pbIAk25Fo6s6E4bIxbLWjzpaLI10z8OzqzMOLJgTEMkzm
 OWbNHCq4dPi6fVZD1FsTFA/dVD2UQkuCR2uYykm5wyvyOCQBb2QAirsm2gCaN0T/4J6FOP8wI
 LTVyVzoLfugYoYh09hjEnr3ILEypxjArmpqxUzrMaavyHlSUwQUD+u8yqmVvFR9TtZNu9Vqo1
 DsKcrE58vOpQy2VM5lOf+vP28nUPFP7HiCc/YgCcth+ZopKo06lPg+9DqXJta5POMqrKUYU/+
 kOYz89IgwtXK2x8DvEILTXQXVVoK5j5LyKtc/m5zSZiHolvK8wk5MMR2pvcIgSu7ecNykd+D8
 YOBKI8tjKKgI5j20652o8n5E3YrGlP1cmwy+VyeC2K9IbRdDmS7AaTcWmaGAb6zQFqnNB2p+Y
 7mLi0dkjP9fmxHvVWKtNCDconqlkb+KVGMChFmWYkG+Qse0+bT+KqZfbevjajsN9ODuc4QhpP
 QeQI7hINLdsojgP7Pfx9nSzzCuF1l8i8pPVfS6SmvupgJdBORbVCieM4Xcpd1zSkt1k+cYcYR
 HF0fh9SQbQaXSuSuEx6KfCNGMnPW/KF7ZVUJig/E+wDCKJVClnjZihX4JfGhC0Cd+2yQAIyY2
 JFSN6fesNsAP5Y+v+j4NJ9gsjHNHZ9X8inrn66Q5mNqLurHYZz7OaMTFu+mQ8jM9tvBaQ41Ly
 1ggd7UGyJ07IqtbqXEwwTfZ2LClR36xDIlbHS3kxEx4CIbzm8+euuZ9IcfHUFQYDTpwx6hzzm
 ZPVpqny6RGvRwxUJh+3CLPKtgW1FwiUbzO8uqed1OWPuMxR6fWj7O2XIDcIm4QF86prJvz1lf
 nI6H48NgeNqbjkUlMStefaS8Ts5LJ4ARD5iyGxEB9+m4ahehxNNn1dy8/SPOFxgQcZyH2cn/9
 1RFEmm+q8zbNnD6cL+zPj+5P7ImXr//G2VOBjYGMBSnG3r1IIHMF7g5B5TEP3mcvXXsOwfp9g
 Fwul0MOhOhzE5J8ofueevqupFVUFnEbqnoHgnxLVY9hs6Vh4ORpjYFDmextqjLSjIghj1R5Wz
 alzO29tS1MLSvVtzIZyBzsOxAP5YqTO/8arExqe/eeFWBPJTp2dsVJ/7V3FU1nUduxMMhQdi9
 ShtaJvbknK4xvk7ORZ+v+xpemiIwS2iSTioUYKtJah4xMrLtWHlyAvBxmJtSY/RxcQJZX6VP3
 a8wXLmFZBHVGck2nCtHp8D0TtXfz7jZLfgqqIgmBX5ghnvWgFWz6xLFcl7j13L2/dDpeOrEJe
 vLKd1hGnGxxWLwsPgrWTx/+Jbp81gBeepMTfjAxPEEAnHrzvrK3YqZwZVZIxM6nOSKFja/YY+
 aJ70oPGlyyuoafNg5XymDLshqBWyDoLjtSapOrcIebvBlDUnKYKtTobLLWledefcuRMLaxrsI
 SFUstSX7gIzt2xZ/S7r83qm0cHtB905dhgF6UV0e54VH7BwLmIo5XW0wk3Z2MiXwTwW1Rcr6L
 +jEEQ3b4shqtPypqVxed8byQMlPet3JFucNBtP+7Qm7g3x5RdqFCEYWdqQqYC+52bnBQ+csGk
 6wRZZBRIHCceM7yjL8Al2MH4EPVT5V+x6M9KuwA1wJkLBuMa4iPuNCo3BbldugKuvoGdW3q1R
 NYj4+kDhI7QqV/XFeXO6CFmTRgGLuW/dtFptx27sTRf3ohJjsAv1Zqu8KfT2G28/X8rcx7gdH
 XyhWSRLRkhCVsh97INWGK384H7PdSyVh8n11QJtDsAFxoWfjxpUUibcWw4Fl/PLkOG6aZ2nGF
 Tbfz+wE35SE33oAIzVesRkL6exSSaxP76GwJqrNyOZr+1z1JmfLMc5YOVOiY87pyuR2gUt3WH
 fbSXLcZcuzIupylMo/c/H+33PQhbyZb6IHLZogZ+5jw2VvVSOCeh99fDXq7ddF/zCGv6see0B
 wnGy0kAq5fY0u9XZCYB2OQESUFTPeabuAOvUhktC3v/ZxeQt6UCTz/wi1dUGQ+8FNx9TyCLEu
 oO9IknG3v/KuKGtsU6UUkxIx8x6rxP20L6wma4sJujLeEoyAn/Q0luxcvGsRg71gyQWmzAUPC
 m367fpNQRfhKdff3sNImL9g4gysKGtdADnhTSdSOkWM8m1CDFX7sMYeTehnlHEwV1d5uUWgnd
 loaE8D7/zg2sIFVTQTAv4qH5aSS3wG9MDi8693M2aZoiTm3Zxcvb/memMvsdBmQJIupNQcb6T
 V1RVzJFWXf9n34+PTLDWF9lFZGvbSS39OVioXP8C8ymE8QpTPWyELcSdC1bmBehj4vxNwgTRF
 5OE4H9C8HEBpirXXOyU5hNJA0NPG6S2iAb79tfxj6s3EXqTrOeOjG+5IiCCLKjvvMWUOgafJ/
 7Ylu2FJ935wS2qjjVkyMrflGZgHvEyueCmdYEGg1S0Or6dfqmkgApzsRUP3BN0Fy+6RzkUze7
 v9KYu0EeBPrfsGlX2D/Q2Ve2lp1bSyG7thJsa8VEBA+s2VfJuYPKJ+xhOnnFD+VZw9EK0O1dI
 /sVgdPe0As/Oi4ElHn7nno9qFW1gBCkIqHU3VgwbVTGghfYayv5+PaO6+s7+0JZGo52Rjr/uX
 49Q3rNgIE3bHyxHHVfQK/XK0xTKXiRrLIx0CiwMjiE16q/vgw/dlgeMN6S0pCMfqZvVn8k3Xq
 zyI500WIEvrp0mEgUeA/sfM+lDmEB9VnJtSOz9WfojVDQQ6lf+V9Fmeud9LtYcpTWAbjUtlpt
 MXkKCKPwNb/8gMho/ODS4xRy3oiQLtGuKbiQyIW8Slsa50NRTXzJxogFcgYUvPPPbTG8FIB+X
 xO979PgQf5RZKMGBLzJqBTXBCUoiptxnZqwjHd+3/XLWPsu9n/A0qawHHH26oEANkb9amJUnO
 /1f/t+MmWPRQtIve6qbhDs0RwgaisA8+3O0Fp+2f8Efk4Zbco3U0Ok9y9zTuOqOAgDZn6eu9J
 2r1JbKJVAkgqET1Qx9wGo1QjvaBSg/RaNHKNlHcL5wskbEbidmEoBi3Entiu+JWOanq5b18Qg
 H24Eetfr00o5fSt2sffCmrPzXU0rmOf3lJk03X1JDriMC/AY2AbezO7715FnmskRDdHhViyOJ
 U8uileQTp1YeKHRHpmiF1aoyIkHS/XogIMPM9Qb9M4NNow4qH5AdQcJoDlUBiLO2hEBCY0Od5
 hbR6rmnKnIc6b4dtDtHbAikAotVgtHpFfOccB2jlqXEnIFtnz1AoaZdDb24NOW11IYp8hUw6C
 RknUPPfTbI3Jte+YjjOnlvJ1TZPu5asjfqTIC

> Restructure error handling in rcu_torture_fwd_prog_init() to provide
> cleaner allocation failure paths. The current code checks both
> allocations
> in a single condition, making error handling less efficient and clear.
=E2=80=A6

I suggest to refine the word wrapping for such a change description.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc5#n658

Regards,
Markus
